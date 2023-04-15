resource "aws_secretsmanager_secret" "cassandra_credentials" {
  name = "cassandra-credentials"
}

resource "aws_secretsmanager_secret_version" "cassandra_credentials_version" {
  secret_id     = aws_secretsmanager_secret.cassandra_credentials.id
  secret_string = jsonencode({
    "username" = aws_iam_service_specific_credential.amazon-keyspaces.service_user_name
    "password" = aws_iam_service_specific_credential.amazon-keyspaces.service_password
  })
  depends_on = [aws_secretsmanager_secret.cassandra_credentials]
}


resource "aws_iam_service_specific_credential" "amazon-keyspaces" {
  service_name = "amazonkeyspaces.amazonaws.com"
  user_name = data.aws_iam_user.terraform-iac.user_name
}

data "aws_iam_user" "terraform-iac" {
  user_name = "terraform-iac"
}


resource "aws_iam_service_linked_role" "keyspaces_service_role" {
  aws_service_name = "cassandra.amazonaws.com"
}

resource "aws_iam_service_specific_credential" "keyspaces_credentials" {
  service_name = "cassandra.amazonaws.com"
  role_arn     = aws_iam_service_linked_role.keyspaces_service_role.arn
}