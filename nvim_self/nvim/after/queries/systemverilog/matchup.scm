; vim-matchup treesitter query for SystemVerilog.
;
; Only positions given here are matched, so:
;   - tokens inside comments are never matched (they live in comment nodes), and
;   - `wait fork` / `disable fork` are wait_statement / disable_statement,
;     not par_block, so they never pair with join / join_any / join_none.
; @scope is required by matchup's engine (it returns nil without it).

; begin ... end
(seq_block
  "begin" @open.block
  "end" @close.block) @scope.block

(generate_block
  "begin" @open.block
  "end" @close.block) @scope.block

; generate ... endgenerate
(generate_region
  "generate" @open.generate
  "endgenerate" @close.generate) @scope.generate

; fork ... join / join_any / join_none
(par_block
  "fork" @open.fork
  (join_keyword) @close.fork) @scope.fork

; module ... endmodule
(module_declaration
  (module_ansi_header
    (module_keyword) @open.module)
  "endmodule" @close.module) @scope.module

(module_declaration
  (module_nonansi_header
    (module_keyword) @open.module)
  "endmodule" @close.module) @scope.module

; interface ... endinterface
(interface_declaration
  (interface_ansi_header
    "interface" @open.interface)
  "endinterface" @close.interface) @scope.interface

; program ... endprogram
(program_declaration
  (program_ansi_header
    "program" @open.program)
  "endprogram" @close.program) @scope.program

; package ... endpackage
(package_declaration
  "package" @open.package
  "endpackage" @close.package) @scope.package

; class ... endclass
(class_declaration
  "class" @open.class
  "endclass" @close.class) @scope.class

; function ... endfunction
(function_declaration
  "function" @open.function
  (function_body_declaration
    "endfunction" @close.function)) @scope.function

; class constructor: function new(...); ... endfunction
; (the grammar gives it its own node type, it is not a function_declaration)
(class_constructor_declaration
  "function" @open.function
  "endfunction" @close.function) @scope.function

; task ... endtask
(task_declaration
  "task" @open.task
  (task_body_declaration
    "endtask" @close.task)) @scope.task

; if ... else
(conditional_statement
  "if" @open.if) @scope.if

(conditional_statement
  "else" @mid.if.1)

; case ... endcase
(case_statement
  (case_keyword) @open.case
  "endcase" @close.case) @scope.case

; property / sequence / covergroup / checker / specify
(property_declaration
  "property" @open.property
  "endproperty" @close.property) @scope.property

(sequence_declaration
  "sequence" @open.sequence
  "endsequence" @close.sequence) @scope.sequence

(covergroup_declaration
  "covergroup" @open.covergroup
  "endgroup" @close.covergroup) @scope.covergroup

(checker_declaration
  "checker" @open.checker
  "endchecker" @close.checker) @scope.checker

(specify_block
  "specify" @open.specify
  "endspecify" @close.specify) @scope.specify

; `ifdef / `ifndef ... `endif
; Each directive is its own one-line node in this grammar (no node spans the
; whole region), so the enclosing module is used as the scope. Consecutive
; regions pair correctly; nesting is not resolved.
(module_declaration
  (conditional_compilation_directive "`ifdef" @open.ifdef)) @scope.ifdef
(module_declaration
  (conditional_compilation_directive "`ifndef" @open.ifdef)) @scope.ifdef
(module_declaration
  (conditional_compilation_directive "`endif" @close.ifdef)) @scope.ifdef
