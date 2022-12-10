;; reimplementation of a subset of hsluv in fennel, along with some utility 
;; functions for saturation, blending, and lighten/darken

;; constants
(local hex-chars :0123456789abcdef)
(local epsilon 0.0088564516)
(local kappa 903.2962962)
(local refY 1)
(local refU 0.19783000664283)
(local refV 0.46831999493879)
(local m
     [[3.2409699419045 (- 1.5373831775701) (- 0.498610760293)]
      [(- 0.96924363628087) 1.8759675015077 0.041555057407175]
      [0.055630079696993 (- 0.20397695888897) 1.0569715142429]])
(local minv
     [[0.41239079926595 0.35758433938387 0.18048078840183]
      [0.21263900587151 0.71516867876775 0.072192315360733]
      [0.019330818715591 0.11919477979462 0.95053215224966]])

;; math stuff
(fn get-bounds [l]
  (let [result {}]
    (var sub2 nil)
    (local sub1 (/ (^ (+ l 16) 3) 1560896))
    (if (> sub1 epsilon) (set sub2 sub1)
        (set sub2 (/ l kappa)))
    (for [i 1 3]
      (local m1 (. (. m i) 1))
      (local m2 (. (. m i) 2))
      (local m3 (. (. m i) 3))
      (for [t 0 1]
        (local top1
               (* (- (* 284517 m1) (* 94839 m3)) sub2))
        (local top2
               (- (* (* (+ (+ (* 838422 m3) (* 769860 m2))
                           (* 731718 m1))
                        l)
                     sub2)
                  (* (* 769860 t) l)))
        (local bottom
               (+ (* (- (* 632260 m3) (* 126452 m2)) sub2)
                  (* 126452 t)))
        (table.insert result
                      {:slope (/ top1 bottom)
                       :intercept (/ top2 bottom)})))
    result))

(fn length-of-ray-until-intersect [theta line]
  (/ line.intercept
     (- (math.sin theta) (* line.slope (math.cos theta)))))

(fn max-safe-chroma-for-lh [l h]
  (let [hrad (* (* (/ h 360) math.pi) 2)
        bounds (get-bounds l)]
    (var min 1.7976931348623e+308)
    (for [i 1 6]
      (local bound (. bounds i))
      (local distance 
             (length-of-ray-until-intersect hrad
                                            bound))
      (when (>= distance 0)
        (set min (math.min min distance))))
    min))


(fn y->l [Y]
  (if (<= Y epsilon) (* (/ Y refY) kappa)
      (- (* 116 (^ (/ Y refY) 0.33333333333333)) 16)))

(fn l->y [L]
  (if (<= L 8) (/ (* refY L) kappa)
      (* refY (^ (/ (+ L 16) 116) 3))))

(fn from_linear [c]
  (if (<= c 0.0031308) (* 12.92 c)
      (- (* 1.055 (^ c 0.41666666666667)) 0.055)))

(fn to_linear [c]
  (if (> c 0.04045) (^ (/ (+ c 0.055) 1.055) 2.4)
      (/ c 12.92)))

(fn dot_product [a b]
  (var sum 0)
  (for [i 1 3]
    (set sum (+ sum (* (. a i) (. b i)))))
  sum)

;; conversion functions
(fn luv->lch [tuple]
  (let [L (. tuple 1)
        U (. tuple 2)
        V (. tuple 3)
        C (math.sqrt (+ (* U U) (* V V)))]
    (var H nil)
    (if (< C 1e-08) (set H 0)
        (do
          (set H
               (/ (* (math.atan2 V U) 180)
                  3.1415926535898))
          (when (< H 0)
            (set H (+ 360 H)))))
    [L C H]))

(fn lch->luv [tuple]
  (let [L (. tuple 1)
        C (. tuple 2)
        Hrad (* (* (/ (. tuple 3) 360) 2) math.pi)]
    [L (* (math.cos Hrad) C) (* (math.sin Hrad) C)]))

(fn xyz->luv [tuple]
  (let [X (. tuple 1)
        Y (. tuple 2)
        divider (+ (+ X (* 15 Y)) (* 3 (. tuple 3)))]
    (var var-u (* 4 X))
    (var var-v (* 9 Y))
    (if (not= divider 0)
        (do
          (set var-u (/ var-u divider))
          (set var-v (/ var-v divider)))
        (do
          (set var-u 0)
          (set var-v 0)))
    (local L (y->l Y))
    (when (= L 0)
      (let [rtn [0 0 0]]
        (lua "return rtn")))
    [L
     (* (* 13 L) (- var-u refU))
     (* (* 13 L) (- var-v refV))]))

(fn luv->xyz [tuple]
  (let [L (. tuple 1)
        U (. tuple 2)
        V (. tuple 3)]
    (when (= L 0)
      (let [rtn [0 0 0]]
        (lua "return rtn")))
    (local var-u (+ (/ U (* 13 L)) refU))
    (local var-v (+ (/ V (* 13 L)) refV))
    (local Y (l->y L))
    (local X
           (- 0
              (/ (* (* 9 Y) var-u)
                 (- (* (- var-u 4) var-v) (* var-u var-v)))))
    [X
     Y
     (/ (- (- (* 9 Y) (* (* 15 var-v) Y)) (* var-v X))
        (* 3 var-v))]))

(fn xyz->rgb [tuple]
  [(from_linear (dot_product (. m 1) tuple))
   (from_linear (dot_product (. m 2) tuple))
   (from_linear (dot_product (. m 3) tuple))])

(fn rgb->xyz [tuple]
  (let [rgbl [(to_linear (. tuple 1))
              (to_linear (. tuple 2))
              (to_linear (. tuple 3))]]
    [(dot_product (. minv 1) rgbl)
     (dot_product (. minv 2) rgbl)
     (dot_product (. minv 3) rgbl)]))

(fn hex->rgb [hex]
  (var hex (string.lower hex))
  (local ret {})
  (for [i 0 2]
    (local char1
           (string.sub hex (+ (* i 2) 2) (+ (* i 2) 2)))
    (local char2
           (string.sub hex (+ (* i 2) 3) (+ (* i 2) 3)))
    (local digit1 (- (string.find hex-chars char1) 1))
    (local digit2 (- (string.find hex-chars char2) 1))
    (tset ret (+ i 1) (/ (+ (* digit1 16) digit2) 255)))
  ret)

(fn rgb->hex [tuple]
  (var h "#")
  (for [i 1 3]
    (local c (math.floor (+ (* (. tuple i) 255) 0.5)))
    (local digit2 (math.fmod c 16))
    (local x (/ (- c digit2) 16))
    (local digit1 (math.floor x))
    (set h
         (.. h
             (string.sub hex-chars (+ digit1 1)
                         (+ digit1 1))))
    (set h
         (.. h
             (string.sub hex-chars (+ digit2 1)
                         (+ digit2 1)))))
  h)

(fn lch->hsluv [tuple]
  (let [L (. tuple 1)
        C (. tuple 2)
        H (. tuple 3)
        max-chroma (max-safe-chroma-for-lh L H)]
    (when (> L 99.9999999)
      (let [rtn [H 0 100]]
        (lua "return rtn")))
    (when (< L 1e-08)
      (let [rtn [H 0 0]]
        (lua "return rtn")))
    [H (* (/ C max-chroma) 100) L]))

(fn hsluv->lch [tuple]
  (let [H (. tuple 1)
        S (. tuple 2)
        L (. tuple 3)]
    (when (> L 99.9999999)
      (let [rtn [100 0 H]]
        (lua "return rtn")))
    (when (< L 1e-08)
      (let [rtn [0 0 H]]
        (lua "return rtn")))
    [L
     (* (/ (max-safe-chroma-for-lh L H) 100) S)
     H]))

(fn rgb->lch [tuple]
  (luv->lch (xyz->luv (rgb->xyz tuple))))

(fn lch->rgb [tuple]
  (xyz->rgb (luv->xyz (lch->luv tuple))))

(fn rgb->hsluv [tuple]
  (lch->hsluv (rgb->lch tuple)))

(fn hsluv->rgb [tuple]
  (lch->rgb (hsluv->lch tuple)))

(fn hex->hsluv [s]
  (rgb->hsluv (hex->rgb s)))

(fn hsluv->hex [tuple]
  (rgb->hex (hsluv->rgb tuple)))

;; Transormation functions
(fn transform-h [c f]
  [(f (. c 1)) (. c 2)     (. c 3)])

(fn transform-s [c f]
  [(. c 1)     (f (. c 2)) (. c 3)])

(fn transform-l [c f]
  [(. c 1)     (. c 2)     (f (. c 3))])

(fn linear-tween [start stop]
  (fn [i] (+ start (* i (- stop start)))))

;; Blending
(fn radial-tween [x y]
  (let [start (math.rad x)
        stop (math.rad y)
        delta (math.atan2 (math.sin (- stop start)) (math.cos (- stop start)))]
    (fn [i] (% (+ 360 (math.deg (+ start (* delta i)))) 360))))

(fn blend-hsluv [start stop ratio]
  (let [ratio (or ratio 0.5)
        h (radial-tween (. start 1) (. stop 1))
        s (linear-tween (. start 2) (. stop 2))
        l (linear-tween (. start 3) (. stop 3))]
    [(h ratio) (s ratio) (l ratio)]))

;; General lighten/darken/whatever
(fn lighten [c n]
  (let [l (linear-tween (. c 3) 100)]
    [(. c 1) (. c 2) (l n)]))

(fn darken [c n]
  (let [l (linear-tween (. c 3) 0)]
    [(. c 1) (. c 2) (l n)]))

(fn saturate [c n]
  (let [s (linear-tween (. c 2) 100)]
    [(. c 1) (s n) (. c 3)]))

(fn desaturate [c n]
  (let [s (linear-tween (. c 2) 0)]
    [(. c 1) (s n) (. c 3)]))

(fn rotate [c n]
  [(% (+ n (. c 1)) 360) (. c 2) (. c 3)])

;; Of course we're dealing with hex codes
(fn blend-hex [c1 c2 r]
  (-> (blend-hsluv (hex->hsluv c1) (hex->hsluv c2) r)
      (hsluv->hex)))

(fn lighten-hex [c n]
  (-> (lighten (hex->hsluv c) n)
      (hsluv->hex)))

(fn darken-hex [c n]
  (-> (darken (hex->hsluv c) n)
      (hsluv->hex)))

(fn saturate-hex [c n]
  (-> (saturate (hex->hsluv c) n)
      (hsluv->hex)))

(fn desaturate-hex [c n]
  (-> (desaturate (hex->hsluv c) n)
      (hsluv->hex)))

(fn rotate-hex [c n]
  (-> (rotate (hex->hsluv c) n)
      (hsluv->hex)))

;; gradient generations
(fn gradient [c1 c2]
  (var ls [])
  (for [i 0.00 1.01 0.02]
    (set ls (vim.list_extend ls [i])))
  (vim.tbl_map #(blend-hex c1 c2 $1) ls))

(fn gradient-n [c1 c2 n]
  (var ls [])
  (let [step (/ 1 (+ n 1))]
    (for [i 1 n 1]
      (set ls (vim.list_extend ls [(* i step)]))))
  (vim.list_extend [c1] (vim.tbl_map #(blend-hex c1 c2 $1) ls) [c2]))


;; base16 colorscheme generation
(math.randomseed (os.time))
(fn random-color [red-range green-range blue-range]
  (let [rgb {:b (math.random (. blue-range 1) (. blue-range 2))
             :r (math.random (. red-range 1) (. red-range 2))
             :g (math.random (. green-range 1) (. green-range 2))}]
    (string.format "#%02x%02x%02x" rgb.r rgb.g rgb.b)))

(fn generate-pallete []
  (let [bghex (random-color [0 63] [0 63] [0 63])
        fghex (random-color [240 255] [240 255] [240 255])]

    (local palette [bghex
                    (blend-hex bghex fghex 0.085)
                    (blend-hex bghex fghex 0.18)
                    (blend-hex bghex fghex 0.3)
                    (blend-hex bghex fghex 0.7)
                    (blend-hex bghex fghex 0.82)
                    (blend-hex bghex fghex 0.95)
                    fghex])

    (local base16-names [:base00
                         :base01
                         :base02
                         :base03
                         :base04
                         :base05
                         :base06
                         :base07
                         :base08
                         :base09
                         :base0A
                         :base0B
                         :base0C
                         :base0D
                         :base0E
                         :base0F])

    (local base16-palette {})
    (each [i hex (ipairs palette)]
      (local name (. base16-names i))
      (tset base16-palette name hex))
    base16-palette))

{: blend-hex
 : lighten-hex
 : darken-hex
 : saturate-hex
 : desaturate-hex
 : rotate-hex
 : gradient
 : gradient-n
 : generate-pallete}
