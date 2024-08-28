;;                               O X O C A R B O N
;;        _..._         _..._         _..._         _..._         _..._
;;      .:::::::.     .::::. `.     .::::  `.     .::'   `.     .'     `.
;;     :::::::::::   :::::::.  :   ::::::    :   :::       :   :         :
;;     :::::::::::   ::::::::  :   ::::::    :   :::       :   :         :
;;     `:::::::::'   `::::::' .'   `:::::   .'   `::.     .'   `.       .'
;;       `':::''       `'::'-'       `'::.-'       `':..-'       `-...-'
;;
;;   Colorscheme name:    oxocarbon themeing system
;;   Description:         Neovim Colorschemes based on base16 in fennel made with (hs)luv <3
;;   Author:              https://github.com/shaunsingh

(local {: blend-hex} (require :oxocarbon.colorutils))

;; utilities

(macro let! [...]
  (fn let-with-scope! [[scope] name value]
    (let [name (tostring name)
          scope (tostring scope)]
      `(tset ,(match scope
                :b `vim.b
                :w `vim.w
                :t `vim.t
                :g `vim.g) ,name ,value)))

  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-with-scope! [:g] name value)
    _ (error "expected let! to have at least two arguments: name value")))

(macro set! [option]
  (let [option (tostring option)]
    `(tset vim.o ,option true)))

(macro custom-set-face! [name attributes colors]
  (let [definition (collect [_ attr (ipairs attributes) &into colors]
                     (tostring attr)
                     true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

;; reset variables

(when vim.g.colors_name
  (vim.cmd.hi :clear))

;; set defaults

(let! colors_name :oxocarbon)
(set! termguicolors)

;; oxocarbon palette

(local base00 "#161616")
(local base06 "#ffffff")
(local base09 "#78a9ff")

(local oxocarbon (or (and (= vim.o.background :dark)
                          {: base00
                           :base01 (blend-hex base00 base06 0.085)
                           :base02 (blend-hex base00 base06 0.18)
                           :base03 (blend-hex base00 base06 0.3)
                           :base04 (blend-hex base00 base06 0.82)
                           :base05 (blend-hex base00 base06 0.95)
                           : base06
                           :base07 "#08bdba"
                           :base08 "#3ddbd9"
                           : base09
                           :base10 "#ee5396"
                           :base11 "#33b1ff"
                           :base12 "#ff7eb6"
                           :base13 "#42be65"
                           :base14 "#be95ff"
                           :base15 "#82cfff"
                           :blend "#131313"
                           :none :NONE})
                     {:base00 base06
                      :base01 (blend-hex base00 base06 0.95)
                      :base02 (blend-hex base00 base06 0.82)
                      :base03 base00
                      :base04 "#37474F"
                      :base05 "#90A4AE"
                      :base06 "#525252"
                      :base07 "#08bdba"
                      :base08 "#ff7eb6"
                      :base09 "#ee5396"
                      :base10 "#FF6F00"
                      :base11 "#0f62fe"
                      :base12 "#673AB7"
                      :base13 "#42be65"
                      :base14 "#be95ff"
                      :base15 "#FFAB91"
                      :blend "#FAFAFA"
                      :none :NONE}))

;; terminal

(let! terminal_color_0 oxocarbon.base01)
(let! terminal_color_1 oxocarbon.base11)
(let! terminal_color_2 oxocarbon.base14)
(let! terminal_color_3 oxocarbon.base13)
(let! terminal_color_4 oxocarbon.base09)
(let! terminal_color_5 oxocarbon.base15)
(let! terminal_color_6 oxocarbon.base08)
(let! terminal_color_7 oxocarbon.base05)
(let! terminal_color_8 oxocarbon.base03)
(let! terminal_color_9 oxocarbon.base11)
(let! terminal_color_10 oxocarbon.base14)
(let! terminal_color_11 oxocarbon.base13)
(let! terminal_color_12 oxocarbon.base09)
(let! terminal_color_13 oxocarbon.base15)
(let! terminal_color_14 oxocarbon.base07)
(let! terminal_color_15 oxocarbon.base06)

;; editor

(custom-set-face! :ColorColumn [] {:fg oxocarbon.none :bg oxocarbon.base01})
(custom-set-face! :Cursor [] {:fg oxocarbon.base00 :bg oxocarbon.base04})
(custom-set-face! :CursorLine [] {:fg oxocarbon.none :bg oxocarbon.base01})
(custom-set-face! :CursorColumn [] {:fg oxocarbon.none :bg oxocarbon.base01})
(custom-set-face! :CursorLineNr [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :QuickFixLine [] {:fg oxocarbon.none :bg oxocarbon.base01})
(custom-set-face! :Error [] {:fg oxocarbon.base10 :bg oxocarbon.base01})
(custom-set-face! :LineNr [] {:fg oxocarbon.base03 :bg oxocarbon.base00})
(custom-set-face! :NonText [] {:fg oxocarbon.base02 :bg oxocarbon.none})
(custom-set-face! :Normal [] {:fg oxocarbon.base04 :bg oxocarbon.base00})
(custom-set-face! :Pmenu [] {:fg oxocarbon.base04 :bg oxocarbon.base01})
(custom-set-face! :PmenuSbar [] {:fg oxocarbon.base04 :bg oxocarbon.base01})
(custom-set-face! :PmenuSel [] {:fg oxocarbon.base08 :bg oxocarbon.base02})
(custom-set-face! :PmenuThumb [] {:fg oxocarbon.base08 :bg oxocarbon.base02})
(custom-set-face! :SpecialKey [] {:fg oxocarbon.base03 :bg oxocarbon.none})
(custom-set-face! :Visual [] {:fg oxocarbon.none :bg oxocarbon.base02})
(custom-set-face! :VisualNOS [] {:fg oxocarbon.none :bg oxocarbon.base02})
(custom-set-face! :TooLong [] {:fg oxocarbon.none :bg oxocarbon.base02})
(custom-set-face! :Debug [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :Macro [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! :MatchParen [:underline]
                  {:fg oxocarbon.none :bg oxocarbon.base02})
(custom-set-face! :Bold [:bold] {:fg oxocarbon.none :bg oxocarbon.none})
(custom-set-face! :Italic [:italic] {:fg oxocarbon.none :bg oxocarbon.none})
(custom-set-face! :Underlined [:underline]
                  {:fg oxocarbon.none :bg oxocarbon.none})

;; diagnostics

(custom-set-face! :DiagnosticWarn [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :DiagnosticError [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :DiagnosticInfo [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :DiagnosticHint [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :DiagnosticUnderlineWarn [:undercurl]
                  {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :DiagnosticUnderlineError [:undercurl]
                  {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :DiagnosticUnderlineInfo [:undercurl]
                  {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :DiagnosticUnderlineHint [:undercurl]
                  {:fg oxocarbon.base04 :bg oxocarbon.none})

;; health
(custom-set-face! :HealthError [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :HealthWarning [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :HealthSuccess [] {:fg oxocarbon.base13 :bg oxocarbon.none})

;; ledger

(custom-set-face! "@comment" [] {:link "Comment"})
(custom-set-face! "@text.literal.commodity" [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! "@number" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@number.date" [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! "@number.date.effective" [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! "@number.interval" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@number.status" [] {:fg oxocarbon.base12 :bg oxocarbon.none})
(custom-set-face! "@number.quantity" [] {:fg oxocarbon.base11 :bg oxocarbon.none})
(custom-set-face! "@number.quantity.negative" [] {:fg oxocarbon.base10 :bg oxocarbon.none})

;; lsp

(custom-set-face! :LspCodeLens [] {:fg oxocarbon.none :bg oxocarbon.base03})
(custom-set-face! :LspReferenceText [] {:fg oxocarbon.none :bg oxocarbon.base03})
(custom-set-face! :LspReferenceread [] {:fg oxocarbon.none :bg oxocarbon.base03})
(custom-set-face! :LspReferenceWrite [] {:fg oxocarbon.none :bg oxocarbon.base03})
(custom-set-face! :LspSignatureActiveParameter [] {:fg oxocarbon.base08 :bg oxocarbon.none})

;; lps-semantic-tokens
(custom-set-face! "@lsp.type.class" [] {:link "Structure"})
(custom-set-face! "@lsp.type.decorator" [] {:link "Decorator"})
(custom-set-face! "@lsp.type.function" [] {:link "@function"})
(custom-set-face! "@lsp.type.macro" [] {:link "Macro"})
(custom-set-face! "@lsp.type.method" [] {:link "@function"})
(custom-set-face! "@lsp.type.struct" [] {:link "Structure"})
(custom-set-face! "@lsp.type.type" [] {:link "Type"})
(custom-set-face! "@lsp.type.typeParameter" [] {:link "Typedef"})
(custom-set-face! "@lsp.type.selfParameter" [] {:link "@variable.builtin"})
(custom-set-face! "@lsp.type.builtinConstant" [] {:link "@constant.builtin"})
(custom-set-face! "@lsp.type.magicFunction" [] {:link "@function.builtin"})
(custom-set-face! "@lsp.type.boolean" [] {:link "@boolean"})
(custom-set-face! "@lsp.type.builtinType" [] {:link "@type.builtin"})
(custom-set-face! "@lsp.type.comment" [] {:link "@comment"})
(custom-set-face! "@lsp.type.enum" [] {:link "@type"})
(custom-set-face! "@lsp.type.enumMember" [] {:link "@constant"})
(custom-set-face! "@lsp.type.escapeSequence" [] {:link "@string.escape"})
(custom-set-face! "@lsp.type.formatSpecifier" [] {:link "@punctuation.special"})
;;(custom-set-face! "@lsp.type.interface" [] {})
(custom-set-face! "@lsp.type.keyword" [] {:link "@keyword"})
(custom-set-face! "@lsp.type.namespace" [] {:link "@namespace"})
(custom-set-face! "@lsp.type.number" [] {:link "@number"})
(custom-set-face! "@lsp.type.operator" [] {:link "@operator"})
(custom-set-face! "@lsp.type.parameter" [] {:link "@parameter"})
(custom-set-face! "@lsp.type.property" [] {:link "@property"})
(custom-set-face! "@lsp.type.selfKeyword" [] {:link "@variable.builtin"})
(custom-set-face! "@lsp.type.string.rust" [] {:link "@string"})
(custom-set-face! "@lsp.type.typeAlias" [] {:link "@type.definition"})
(custom-set-face! "@lsp.type.unresolvedReference" [] {:link "Error"})
(custom-set-face! "@lsp.type.variable" [] {:link "@variable"} )
(custom-set-face! "@lsp.mod.readonly" [] {:link "@constant"})
(custom-set-face! "@lsp.mod.typeHint" [] {:link "Type"})
(custom-set-face! "@lsp.mod.builtin" [] {:link "Special"})
(custom-set-face! "@lsp.typemod.class.defaultLibrary" [] {:link "@type.builtin"})
(custom-set-face! "@lsp.typemod.enum.defaultLibrary" [] {:link "@type.builtin"})
(custom-set-face! "@lsp.typemod.enumMember.defaultLibrary" [] {:link "@constant.builtin"})
(custom-set-face! "@lsp.typemod.function.defaultLibrary" [] {:link "@function.builtin"})
(custom-set-face! "@lsp.typemod.keyword.async" [] {:link "@keyword.coroutine"})
(custom-set-face! "@lsp.typemod.macro.defaultLibrary" [] {:link "@function.builtin"})
(custom-set-face! "@lsp.typemod.method.defaultLibrary" [] {:link "@function.builtin"})
(custom-set-face! "@lsp.typemod.operator.injected" [] {:link "@operator"})
(custom-set-face! "@lsp.typemod.string.injected" [] {:link "@string"})
(custom-set-face! "@lsp.typemod.operator.controlFlow" [] {:link "@exception"})
(custom-set-face! "@lsp.typemod.keyword.documentation" [] {:link "Special"})
(custom-set-face! "@lsp.typemod.variable.global" [] {:link "@constant"})
(custom-set-face! "@lsp.typemod.variable.static" [] {:link "@constant"})
(custom-set-face! "@lsp.typemod.variable.defaultLibrary" [] {:link "Special"})
(custom-set-face! "@lsp.typemod.function.builtin" [] {:link "@function.builtin"})
(custom-set-face! "@lsp.typemod.function.readonly" [] {:link "@method"})
;;(custom-set-face! "@lsp.typemod.type.defaultLibrary" [] {})
(custom-set-face! "@lsp.typemod.variable.defaultLibrary" [] {:link "@variable.builtin"})
(custom-set-face! "@lsp.typemod.variable.injected" [] {:link "@variable"})

;; gutter

(custom-set-face! :Folded [] {:fg oxocarbon.base02 :bg oxocarbon.base01})
(custom-set-face! :FoldColumn [] {:fg oxocarbon.base01 :bg oxocarbon.base00})
(custom-set-face! :SignColumn [] {:fg oxocarbon.base01 :bg oxocarbon.base00})

;; navigation

(custom-set-face! :Directory [] {:fg oxocarbon.base08 :bg oxocarbon.none})

;; prompts

(custom-set-face! :EndOfBuffer [] {:fg oxocarbon.base01 :bg oxocarbon.none})
(custom-set-face! :ErrorMsg [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :ModeMsg [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :MoreMsg [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :Question [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :Substitute [] {:fg oxocarbon.base01 :bg oxocarbon.base08})
(custom-set-face! :WarningMsg [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :WildMenu [] {:fg oxocarbon.base08 :bg oxocarbon.base01})

;; vimhelp

(custom-set-face! :helpHyperTextJump []
                  {:fg oxocarbon.base08 :bg oxocarbon.none})

(custom-set-face! :helpSpecial [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :helpHeadline [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :helpHeader [] {:fg oxocarbon.base15 :bg oxocarbon.none})

;; diff

(custom-set-face! :DiffAdded [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! :DiffChanged [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :DiffRemoved [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :DiffAdd [] {:bg "#122f2f" :fg oxocarbon.none})
(custom-set-face! :DiffChange [] {:bg "#222a39" :fg oxocarbon.none})
(custom-set-face! :DiffText [] {:bg "#2f3f5c" :fg oxocarbon.none})
(custom-set-face! :DiffDelete [] {:bg "#361c28" :fg oxocarbon.none})

;; search

(custom-set-face! :IncSearch [] {:fg oxocarbon.base06 :bg oxocarbon.base10})
(custom-set-face! :Search [] {:fg oxocarbon.base01 :bg oxocarbon.base08})

;; tabs

(custom-set-face! :TabLine [] {:link "StatusLineNC"})
(custom-set-face! :TabLineFill [] {:link "TabLine"})
(custom-set-face! :TabLineSel [] {:link "StatusLine"})

;; window

(custom-set-face! :Title [] {:fg oxocarbon.base04 :bg oxocarbon.none})
;; VertSplit has been replaced by `WinSpeperator` in nvim 0.10
(custom-set-face! :VertSplit [] {:fg oxocarbon.base01 :bg oxocarbon.base00})
(custom-set-face! :WinSeparator [] {:fg oxocarbon.base01 :bg oxocarbon.base00})

;; regular syntax

(custom-set-face! :Boolean [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Character [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :Comment [:italic]
                  {:fg oxocarbon.base03 :bg oxocarbon.none})
(custom-set-face! :Conceal [] {:fg oxocarbon.none :bg oxocarbon.none})
(custom-set-face! :Conditional [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Constant [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :Decorator [] {:fg oxocarbon.base12 :bg oxocarbon.none})
(custom-set-face! :Define [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Delimeter [] {:fg oxocarbon.base06 :bg oxocarbon.none})
(custom-set-face! :Exception [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Float [] {:link "Number"})
(custom-set-face! :Function [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :Identifier [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :Include [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Keyword [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Label [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Number [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! :Operator [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :PreProc [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Repeat [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Special [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :SpecialChar [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :SpecialComment [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :Statement [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :StorageClass [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :String [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :Structure [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Tag [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :Todo [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :Type [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :Typedef [] {:fg oxocarbon.base09 :bg oxocarbon.none})

;; markdown

(custom-set-face! :markdownBlockquote []
                  {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :markdownBold [] {:link "Bold"})
(custom-set-face! :markdownItalic [] {:link "Italic"})
(custom-set-face! :markdownBoldItalic [:bold :italic]
                  {:fg oxocarbon.none :bg oxocarbon.none})
(custom-set-face! :markdownRule [] {:link "Comment"})
(custom-set-face! :markdownH1 [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :markdownH2 [] {:link "markdownH1"})
(custom-set-face! :markdownH3 [] {:link "markdownH1"})
(custom-set-face! :markdownH4 [] {:link "markdownH1"})
(custom-set-face! :markdownH5 [] {:link "markdownH1"})
(custom-set-face! :markdownH6 [] {:link "markdownH1"})
(custom-set-face! :markdownHeadingDelimiter [] {:link "markdownH1"})
(custom-set-face! :markdownHeadingRule [] {:link "markdownH1"})
(custom-set-face! :markdownUrl [:underline]
                  {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :markdownCode [] {:link "String"})
(custom-set-face! :markdownCodeBlock [] {:link "markdownCode"})
(custom-set-face! :markdownCodeDelimiter [] {:link "markdownCode"})
(custom-set-face! :markdownUrl [] {:link "String"})
(custom-set-face! :markdownListMarker []
                  {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :markdownOrderedListMarker []
                  {:fg oxocarbon.base08 :bg oxocarbon.none})

;; asciidoc

(custom-set-face! :asciidocAttributeEntry [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! :asciidocAttributeList [] {:link "asciidocAttributeEntry"})
(custom-set-face! :asciidocAttributeRef [] {:link "asciidocAttributeEntry"})
(custom-set-face! :asciidocHLabel [] {:link "markdownH1"})
(custom-set-face! :asciidocOneLineTitle [] {:link "markdownH1"})
(custom-set-face! :asciidocQuotedMonospaced [] {:link "markdownBlockquote"})
(custom-set-face! :asciidocURL [] {:link "markdownUrl"})

;; treesitter
;;; misc

(custom-set-face! "@comment" [] {:link "Comment"})
(custom-set-face! "@error" [] {:fg oxocarbon.base11 :bg oxocarbon.none})

;; @none
;; @preproc
;; @define

(custom-set-face! "@operator" [] {:link "Operator"})

;;; punctuation

(custom-set-face! "@punctuation.delimiter" [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! "@punctuation.bracket" [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! "@punctuation.special" [] {:fg oxocarbon.base08 :bg oxocarbon.none})

;;; literals

(custom-set-face! "@string" [] {:link "String"})
(custom-set-face! "@string.regex" [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! "@string.escape" [] {:fg oxocarbon.base15 :bg oxocarbon.none})

;; @string.special

(custom-set-face! "@character" [] {:link "Character"})

;; @character.special

(custom-set-face! "@boolean" [] {:link "Boolean"})
(custom-set-face! "@number" [] {:link "Number"})
(custom-set-face! "@float" [] {:link "Float"})

;;; functions

(custom-set-face! "@function" [:bold]
                  {:fg oxocarbon.base12 :bg oxocarbon.none})
(custom-set-face! "@function.builtin" [] {:fg oxocarbon.base12 :bg oxocarbon.none})

;; @function.call

(custom-set-face! "@function.macro" [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! "@method" [] {:fg oxocarbon.base07 :bg oxocarbon.none})

;; @method.call

(custom-set-face! "@constructor" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@parameter" [] {:fg oxocarbon.base04 :bg oxocarbon.none})

;;; keywords

(custom-set-face! "@keyword" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@keyword.function" [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! "@keyword.operator" [] {:fg oxocarbon.base08 :bg oxocarbon.none})

;; @keyword.return

(custom-set-face! "@conditional" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@repeat" [] {:fg oxocarbon.base09 :bg oxocarbon.none})

;; @debug

(custom-set-face! "@label" [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! "@include" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@exception" [] {:fg oxocarbon.base15 :bg oxocarbon.none})

;;; types

(custom-set-face! "@type" [] {:link "Type"})
(custom-set-face! "@type.builtin" [] {:link "Type"})

;; @type.defintion
;; @type.qualifier
;; @storageclass
;; @storageclass.lifetime

(custom-set-face! "@attribute" [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! "@field" [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! "@property" [] {:fg oxocarbon.base10 :bg oxocarbon.none})

;;; identifiers

(custom-set-face! "@variable" [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! "@variable.builtin" [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! "@constant" [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! "@constant.builtin" [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! "@constant.macro" [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! "@namespace" [] {:fg oxocarbon.base07 :bg oxocarbon.none})
(custom-set-face! "@symbol" [:bold]
                  {:fg oxocarbon.base15 :bg oxocarbon.none})

;;; text

(custom-set-face! "@text" [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! "@text.strong" [] {:fg oxocarbon.none :bg oxocarbon.none})
(custom-set-face! "@text.emphasis" [:bold]
                  {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! "@text.underline" [:underline]
                  {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! "@text.strike" [:strikethrough]
                  {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! "@text.title" [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! "@text.literal" [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! "@text.uri" [:underline]
                  {:fg oxocarbon.base14 :bg oxocarbon.none})

;; @text.math
;; @text.environment
;; @text.environment.name
;; @text.reference
;; @text.todo
;; @text.note
;; @text.warning
;; @text.danger
;; @text.diff.add
;; @text.diff.delete
;;; tags

(custom-set-face! "@tag" [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! "@tag.attribute" [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! "@tag.delimiter" [] {:fg oxocarbon.base15 :bg oxocarbon.none})

;;; Conceal
;; @conceal
;;; Spell
;; @spell
;; @nospell
;;; non-standard
;; @variable.global
;;; locals
;; @definition
;; @definition.constant
;; @definition.function
;; @definition.method
;; @definition.var
;; @definition.parameter
;; @definition.macro
;; @definition.type
;; @definition.field
;; @definition.enum
;; @definition.namespace
;; @definition.import
;; @definition.associated
;; @scope

(custom-set-face! "@reference" [] {:fg oxocarbon.base04 :bg oxocarbon.none})

;; neovim

(custom-set-face! :NvimInternalError [] {:fg oxocarbon.base00 :bg oxocarbon.base08})
(custom-set-face! :NormalFloat [] {:fg oxocarbon.base05 :bg oxocarbon.blend})
(custom-set-face! :FloatBorder [] {:fg oxocarbon.blend :bg oxocarbon.blend})
(custom-set-face! :NormalNC [] {:fg oxocarbon.base05 :bg oxocarbon.base00})
(custom-set-face! :TermCursor [] {:fg oxocarbon.base00 :bg oxocarbon.base04})
(custom-set-face! :TermCursorNC [] {:fg oxocarbon.base00 :bg oxocarbon.base04})

;; statusline/winbar

(custom-set-face! :StatusLine [] {:fg oxocarbon.base04 :bg oxocarbon.base00})
(custom-set-face! :StatusLineNC [] {:fg oxocarbon.base04 :bg oxocarbon.base01})
(custom-set-face! :StatusReplace [] {:fg oxocarbon.base00 :bg oxocarbon.base08})
(custom-set-face! :StatusInsert [] {:fg oxocarbon.base00 :bg oxocarbon.base12})
(custom-set-face! :StatusVisual [] {:fg oxocarbon.base00 :bg oxocarbon.base14})
(custom-set-face! :StatusTerminal [] {:fg oxocarbon.base00 :bg oxocarbon.base11})
(custom-set-face! :StatusNormal [] {:fg oxocarbon.base00 :bg oxocarbon.base15})
(custom-set-face! :StatusCommand [] {:fg oxocarbon.base00 :bg oxocarbon.base13})
(custom-set-face! :StatusLineDiagnosticWarn [:bold]
                  {:fg oxocarbon.base14 :bg oxocarbon.base00})
(custom-set-face! :StatusLineDiagnosticError [:bold]
                  {:fg oxocarbon.base10 :bg oxocarbon.base00})

;; telescope

(custom-set-face! :TelescopeBorder [] {:fg oxocarbon.blend :bg oxocarbon.blend})
(custom-set-face! :TelescopePromptBorder [] {:fg oxocarbon.base02 :bg oxocarbon.base02})
(custom-set-face! :TelescopePromptNormal [] {:fg oxocarbon.base05 :bg oxocarbon.base02})
(custom-set-face! :TelescopePromptPrefix [] {:fg oxocarbon.base08 :bg oxocarbon.base02})
(custom-set-face! :TelescopeNormal [] {:fg oxocarbon.none :bg oxocarbon.blend})
(custom-set-face! :TelescopePreviewTitle [] {:fg oxocarbon.base02 :bg oxocarbon.base12})
(custom-set-face! :TelescopePromptTitle [] {:fg oxocarbon.base02 :bg oxocarbon.base11})
(custom-set-face! :TelescopeResultsTitle [] {:fg oxocarbon.blend :bg oxocarbon.blend})
(custom-set-face! :TelescopeSelection [] {:fg oxocarbon.none :bg oxocarbon.base02})
(custom-set-face! :TelescopePreviewLine [] {:fg oxocarbon.none :bg oxocarbon.base01})
(custom-set-face! :TelescopeMatching [:bold :italic] {:fg oxocarbon.base08 :bg oxocarbon.none})

;; notify

(custom-set-face! :NotifyERRORBorder [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :NotifyWARNBorder [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :NotifyINFOBorder [] {:fg oxocarbon.base05 :bg oxocarbon.none})
(custom-set-face! :NotifyDEBUGBorder [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :NotifyTRACEBorder [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :NotifyERRORIcon [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :NotifyWARNIcon [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :NotifyINFOIcon [] {:fg oxocarbon.base05 :bg oxocarbon.none})
(custom-set-face! :NotifyDEBUGIcon [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :NotifyTRACEIcon [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :NotifyERRORTitle [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :NotifyWARNTitle [] {:fg oxocarbon.base14 :bg oxocarbon.none})
(custom-set-face! :NotifyINFOTitle [] {:fg oxocarbon.base05 :bg oxocarbon.none})
(custom-set-face! :NotifyDEBUGTitle [] {:fg oxocarbon.base13 :bg oxocarbon.none})
(custom-set-face! :NotifyTRACETitle [] {:fg oxocarbon.base13 :bg oxocarbon.none})

;; cmp

(custom-set-face! :CmpItemAbbr [] {:fg "#adadad" :bg oxocarbon.none})
(custom-set-face! :CmpItemAbbrMatch [:bold]
                  {:fg oxocarbon.base05 :bg oxocarbon.none})
(custom-set-face! :CmpItemAbbrMatchFuzzy [:bold]
                  {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :CmpItemMenu [:italic]
                  {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :CmpItemKindInterface [] {:fg oxocarbon.base01 :bg oxocarbon.base08})
(custom-set-face! :CmpItemKindColor [] {:fg oxocarbon.base01 :bg oxocarbon.base08})
(custom-set-face! :CmpItemKindTypeParameter [] {:fg oxocarbon.base01 :bg oxocarbon.base08})
(custom-set-face! :CmpItemKindText [] {:fg oxocarbon.base01 :bg oxocarbon.base09})
(custom-set-face! :CmpItemKindEnum [] {:fg oxocarbon.base01 :bg oxocarbon.base09})
(custom-set-face! :CmpItemKindKeyword [] {:fg oxocarbon.base01 :bg oxocarbon.base09})
(custom-set-face! :CmpItemKindConstant [] {:fg oxocarbon.base01 :bg oxocarbon.base10})
(custom-set-face! :CmpItemKindConstructor [] {:fg oxocarbon.base01 :bg oxocarbon.base10})
(custom-set-face! :CmpItemKindReference [] {:fg oxocarbon.base01 :bg oxocarbon.base10})
(custom-set-face! :CmpItemKindFunction [] {:fg oxocarbon.base01 :bg oxocarbon.base11})
(custom-set-face! :CmpItemKindStruct [] {:fg oxocarbon.base01 :bg oxocarbon.base11})
(custom-set-face! :CmpItemKindClass [] {:fg oxocarbon.base01 :bg oxocarbon.base11})
(custom-set-face! :CmpItemKindModule [] {:fg oxocarbon.base01 :bg oxocarbon.base11})
(custom-set-face! :CmpItemKindOperator [] {:fg oxocarbon.base01 :bg oxocarbon.base11})
(custom-set-face! :CmpItemKindField [] {:fg oxocarbon.base01 :bg oxocarbon.base12})
(custom-set-face! :CmpItemKindProperty [] {:fg oxocarbon.base01 :bg oxocarbon.base12})
(custom-set-face! :CmpItemKindEvent [] {:fg oxocarbon.base01 :bg oxocarbon.base12})
(custom-set-face! :CmpItemKindUnit [] {:fg oxocarbon.base01 :bg oxocarbon.base13})
(custom-set-face! :CmpItemKindSnippet [] {:fg oxocarbon.base01 :bg oxocarbon.base13})
(custom-set-face! :CmpItemKindFolder [] {:fg oxocarbon.base01 :bg oxocarbon.base13})
(custom-set-face! :CmpItemKindVariable [] {:fg oxocarbon.base01 :bg oxocarbon.base14})
(custom-set-face! :CmpItemKindFile [] {:fg oxocarbon.base01 :bg oxocarbon.base14})
(custom-set-face! :CmpItemKindMethod [] {:fg oxocarbon.base01 :bg oxocarbon.base15})
(custom-set-face! :CmpItemKindValue [] {:fg oxocarbon.base01 :bg oxocarbon.base15})
(custom-set-face! :CmpItemKindEnumMember [] {:fg oxocarbon.base01 :bg oxocarbon.base15})

;; nvimtree

(custom-set-face! :NvimTreeImageFile [] {:fg oxocarbon.base12 :bg oxocarbon.none})
(custom-set-face! :NvimTreeFolderIcon [] {:fg oxocarbon.base12 :bg oxocarbon.none})
(custom-set-face! :NvimTreeWinSeparator [] {:fg oxocarbon.base00 :bg oxocarbon.base00})
(custom-set-face! :NvimTreeFolderName [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :NvimTreeIndentMarker [] {:fg oxocarbon.base02 :bg oxocarbon.none})
(custom-set-face! :NvimTreeEmptyFolderName [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! :NvimTreeOpenedFolderName [] {:fg oxocarbon.base15 :bg oxocarbon.none})
(custom-set-face! :NvimTreeNormal [] {:fg oxocarbon.base04 :bg oxocarbon.base00})

;; neogit

(custom-set-face! :NeogitBranch [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :NeogitRemote [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :NeogitHunkHeader [] {:fg oxocarbon.base04 :bg oxocarbon.base02})
(custom-set-face! :NeogitHunkHeaderHighlight [] {:fg oxocarbon.base04 :bg oxocarbon.base03})

;; hydra

(custom-set-face! :HydraRed [] {:fg oxocarbon.base12 :bg oxocarbon.none})
(custom-set-face! :HydraBlue [] {:fg oxocarbon.base09 :bg oxocarbon.none})
(custom-set-face! :HydraAmaranth [] {:fg oxocarbon.base10 :bg oxocarbon.none})
(custom-set-face! :HydraTeal [] {:fg oxocarbon.base08 :bg oxocarbon.none})
(custom-set-face! :HydraHint [] {:fg oxocarbon.none :bg oxocarbon.blend})

;; alpha

(custom-set-face! :alpha1 [] {:fg oxocarbon.base03 :bg oxocarbon.none})
(custom-set-face! :alpha2 [] {:fg oxocarbon.base04 :bg oxocarbon.none})
(custom-set-face! :alpha3 [] {:fg oxocarbon.base03 :bg oxocarbon.none})

;; headlines.nvim

(custom-set-face! :CodeBlock [] {:fg oxocarbon.none :bg oxocarbon.base01})

;; nvim-bufferline

(custom-set-face! :BufferLineDiagnostic [:bold]
                  {:fg oxocarbon.base10 :bg oxocarbon.none})

(custom-set-face! :BufferLineDiagnosticVisible [:bold]
                  {:fg oxocarbon.base10 :bg oxocarbon.none})

;; preservim/vim-markdown

(custom-set-face! :htmlH1 [] {:link "markdownH1"})
(custom-set-face! :mkdRule [] {:link "markdownRule"})
(custom-set-face! :mkdListItem [] {:link "markdownListMarker"})
(custom-set-face! :mkdListItemCheckbox [] {:link "markdownListMarker"})

;; vimwiki/vimwiki

(custom-set-face! :VimwikiHeader1 [] {:link "markdownH1"})
(custom-set-face! :VimwikiHeader2 [] {:link "markdownH1"})
(custom-set-face! :VimwikiHeader3 [] {:link "markdownH1"})
(custom-set-face! :VimwikiHeader4 [] {:link "markdownH1"})
(custom-set-face! :VimwikiHeader5 [] {:link "markdownH1"})
(custom-set-face! :VimwikiHeader6 [] {:link "markdownH1"})
(custom-set-face! :VimwikiHeaderChar [] {:link "markdownH1"})
(custom-set-face! :VimwikiList [] {:link "markdownListMarker"})
(custom-set-face! :VimwikiLink [] {:link "markdownUrl"})
(custom-set-face! :VimwikiCode [] {:link "markdownCode"})

{ : oxocarbon }
