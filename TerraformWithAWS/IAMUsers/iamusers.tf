#craete Users
resource "aws_iam_user" "User1" {
  name = "User1"
}

resource "aws_iam_user" "User2" {
  name = "User2"
}

#Create users Group

resource "aws_iam_group" "Administrators" {
  name = "Administrators"
 }

#assign the users to group

resource "aws_iam_group_membership" "Adminusers" {
  name = "Adminusers"

  users = [
    aws_iam_user.User1.name
    aws_iam_user.User2.name
  ]

  group = aws_iam_group.Administrators.name
}

#Policy for the group

resource "aws_iam_policy_attachment" "Adminusers-attach" {
  name       = "Adminusers-attach"
  groups     = [aws_iam_group.Administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}