output "instance_public_ips" {
  value = {
    for env in distinct(values(aws_instance.tester_instance)[*].tags.Environment) :
    env => [
        for k, inst in aws_instance.tester_instance : inst.public_ip if inst.tags.Environment == env
    ]
  }
}