# simple-go-app-with-aws
Simple golang-app with terraform and aws

## Architecture Overview

The golang application(steeleye-app.go) is hosted on 2 EC2 instances and an ELB is used for loadbalancing the traffic on to these two instances.
The application is for displaying the output as:

    Hi there, I'm served from <hostname>
  
The folder structure of the project is:
```
.
├── app.tf
├── elb.tf
├── README.md
├── setup.sh
├── src
│   └── steeleye-app.go
└── variables.tf

```

## Terraform is being used for both provisioning and bootstrapping the ec2 instances to launch the app, "steeleye-app.go" :

1) Terraform to provision the infrastructure as shown below
    - app.tf (for provisioning 2 ec2 instances in AWS and bootstrapping them with go application launch)
    - elb.tf (for provisioning loadbalancer in AWS) 
    - variables.tf (for declaring variables like aws region, vpc etc)
    
2) setup.sh is used for updating software on ec2 instances.

## Deployment

Step1:
Clone the github repo,  git clone git@github.com:paravx2020/simple-go-app-with-aws.git

Step2:
Make sure you are good with 

* a) aws configure - setting up your ACCESS_KEY and SECRET_KEY
* b) you have appropriate private-key is in place in the home folder. Or you can modify the app.tf & variables.tf according to your setup 

Step3:
Run terraform commands as shown below
```
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.12.0...
- Installed hashicorp/aws v3.12.0 (signed by HashiCorp)

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/aws: version = "~> 3.12.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
$
```

Once terraform initialized run the commands
- terraform plan -out plan0001 (and makesure no errors/warnings are present)
- terraform apply "plan0001"

```
$ terraform plan -out plan0001
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.aws_availability_zones.available: Refreshing state...
data.aws_vpc.default: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_elb.example will be created
  + resource "aws_elb" "example" {
      + arn                         = (known after apply)
      + availability_zones          = [
          + "eu-west-1a",
          + "eu-west-1b",
        ]
      + connection_draining         = true
      + connection_draining_timeout = 400
      + cross_zone_load_balancing   = true
      + dns_name                    = (known after apply)
      + id                          = (known after apply)
      + idle_timeout                = 400
      + instances                   = (known after apply)
      + internal                    = (known after apply)
      + name                        = "steeleye"
      + security_groups             = (known after apply)
      + source_security_group       = (known after apply)
      + source_security_group_id    = (known after apply)
      + subnets                     = (known after apply)
      + zone_id                     = (known after apply)

      + health_check {
          + healthy_threshold   = 2
          + interval            = 30
          + target              = "HTTP:8484/"
          + timeout             = 3
          + unhealthy_threshold = 2
        }

      + listener {
          + instance_port     = 8484
          + instance_protocol = "http"
          + lb_port           = 8484
          + lb_protocol       = "http"
        }
    }

  # aws_elb_attachment.myattach[0] will be created
  + resource "aws_elb_attachment" "myattach" {
      + elb      = (known after apply)
      + id       = (known after apply)
      + instance = (known after apply)
    }

  # aws_elb_attachment.myattach[1] will be created
  + resource "aws_elb_attachment" "myattach" {
      + elb      = (known after apply)
      + id       = (known after apply)
      + instance = (known after apply)
    }

  # aws_instance.myInstance[0] will be created
  + resource "aws_instance" "myInstance" {
      + ami                          = "ami-06fd8a495a537da8b"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "terraform_keypair"
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name"        = "dev"
          + "Terraformed" = "true"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.myInstance[1] will be created
  + resource "aws_instance" "myInstance" {
      + ami                          = "ami-06fd8a495a537da8b"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "terraform_keypair"
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name"        = "dev"
          + "Terraformed" = "true"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_security_group.elb will be created
  + resource "aws_security_group" "elb" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 8484
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8484
            },
        ]
      + name                   = "steeleye"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.ubuntu will be created
  + resource "aws_security_group" "ubuntu" {
      + arn                    = (known after apply)
      + description            = "Allow HTTP, HTTPS and SSH traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 8484
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8484
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTPS"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "ubuntu-security-group"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "terraform"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 7 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: plan0001

To perform exactly these actions, run the following command to apply:
    terraform apply "plan0001"

$ 
```
    
And finally, terraform apply "plan0001" 

```
<output truncated>
*    ...
*    ...
*    ...

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate

Outputs:

DNS = ec2-54-75-14-167.eu-west-1.compute.amazonaws.com and ec2-34-251-110-249.eu-west-1.compute.amazonaws.com
elb_dns_name = steeleye-26553243.eu-west-1.elb.amazonaws.com
$
```
## OUTPUTS

### EC2 instances with their public DNS:

* ec2-54-75-14-167.eu-west-1.compute.amazonaws.com and 
* ec2-34-251-110-249.eu-west-1.compute.amazonaws.com

### Load Balancer DNS 
elb_dns_name = steeleye-26553243.eu-west-1.elb.amazonaws.com

Now you open the browser, and paste the **steeleye-26553243.eu-west-1.elb.amazonaws.com:8484/**


