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





