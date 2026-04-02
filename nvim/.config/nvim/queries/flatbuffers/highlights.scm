; Keywords
[
  "namespace"
  "include"
  "table"
  "struct"
  "enum"
  "union"
  "root_type"
  "rpc_service"
  "file_extension"
  "file_identifier"
  "attribute"
] @keyword

; Builtin types
(builtin_type) @type.builtin

; Type references
(type (identifier) @type)
(enum_decl name: (identifier) @type)
(union_decl name: (identifier) @type)
(type_decl name: (identifier) @type)

; Field names
(field_decl name: (identifier) @property)
(object_field key: (identifier) @property)
(metadata_entry key: (identifier) @property)

; Enum values
(enumval_decl name: (identifier) @constant)
(unionval_decl name: (identifier) @type)

; RPC
(rpc_decl name: (identifier) @function)
(rpc_method name: (identifier) @function.method)
(rpc_method request: (identifier) @type)
(rpc_method response: (identifier) @type)

; Namespace
(full_ident (identifier) @namespace)

; Literals
(string_constant) @string
(integer_constant) @number
(float_constant) @number.float
(boolean_constant) @boolean

; Punctuation
[
  "{"
  "}"
  "["
  "]"
  "("
  ")"
] @punctuation.bracket

[
  ":"
  ";"
  ","
  "."
  "="
] @punctuation.delimiter

; Comments
(comment) @comment
