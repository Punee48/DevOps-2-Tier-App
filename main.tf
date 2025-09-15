data "aws_ami" "get_Ubuntu" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hzm"]
    }
  
}

resource "aws_security_group" "Allow_Default_Port" {
    name = "Allow_Default_Port"
    vpc_id = "vpc-0cf527a271720f1c1"

    ingress = [
        for ports in [80, 22, 8080, 3000, 9000]: {
            from_port = ports
            to_port = ports
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "JenkinsMaster" {
    ami = data.aws_ami.get_Ubuntu.id
    instance_type = "t2.medium"
    key_name = "punee-aws-key"
    vpc_security_group_ids = [aws_security_group.Allow_Default_Port.id]
    user_data = file("${path.module}/install.sh")
    root_block_device {
        volume_size = 30
        volume_type = "gp2"
    }

    tags = {
        name="JenkinsMaster"
    }
  
}

resource "aws_instance" "JenkinsAgent" {
    ami = data.aws_ami.get_Ubuntu.id
    instance_type = "t2.micro"
    key_name = "punee-aws-key"
    vpc_security_group_ids = [aws_security_group.Allow_Default_Port.id]
    root_block_device {
        volume_size = 30
        volume_type = "gp2"
    }

    tags = {
        name="JenkinsAgent"
    }
}
