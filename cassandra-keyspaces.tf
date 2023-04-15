resource "aws_keyspaces_keyspace" "example" {
  name = "my_keyspace"
}

resource "aws_keyspaces_table" "example" {
  keyspace_name = aws_keyspaces_keyspace.example.name
  table_name    = "my_table"

  schema_definition {
    column {
      name = "Message"
      type = "ASCII"
    }

    partition_key {
      name = "Message"
    }
  }
}