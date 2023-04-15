output "cassandra_username" {
  value = aws_iam_service_specific_credential.amazon-keyspaces.service_user_name
}

output "cassandra_password" {
  value = aws_iam_service_specific_credential.amazon-keyspaces.service_password
  sensitive = true
}