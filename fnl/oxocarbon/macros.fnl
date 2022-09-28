(λ let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope)) "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope))
                      (= :w (->str scope))
                      (= :t (->str scope))
                      (= :g (->str scope))) "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b 'vim.b
              :w 'vim.w
              :t 'vim.t
              :g 'vim.g) ,name ,value)))

(λ let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
   (match [...]
     [[scope] name value] (let-with-scope! [scope] name value)
     [name value] (let-global! name value)
     _ (error "expected let! to have at least two arguments: name value")))

(λ custom-set-face! [name attributes colors]
  "Sets a highlight group globally using the vim.api.nvim_set_hl API.
  Accepts the following arguments:
  name -> a symbol.
  attributes -> a list of boolean attributes:
    - bold
    - italic
    - reverse
    - inverse
    - standout
    - underline
    - underlineline
    - undercurl
    - underdot
    - underdash
    - strikethrough
    - default
  colors -> a table of colors:
    - fg
    - bg
    - ctermfg
    - ctermbg
  Example of use:
  ```fennel
  (custom-set-face! Error [:bold] {:fg \"#ff0000\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_set_hl 0 \"Error\" {:fg \"#ff0000\"
                                    :bold true})
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (tbl? attributes) "expected table for attributes" attributes)
  (assert-compile (tbl? colors) "expected colors for colors" colors)
  (let [name (->str name)
        definition (collect [_ attr (ipairs attributes)
                             :into colors]
                     (->str attr) true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

{: let!
 : custom-set-face!}
