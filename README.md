# Lab 1: Introduction to AWS and Infrastructure as Code


## 1. Overview and Objectives

This lab introduces you to fundamental AWS concepts and infrastructure-as-code practices. You will build a Virtual Private Cloud (VPC) with public subnets, launch EC2 instances, configure web servers, establish VPC peering connections and monitor your infrastructure using CloudWatch. Finally, you'll recreate your infrastructure using Terraform to learn infrastructure-as-code principles.

**Team Structure:**
- Work in teams of 2
- You will need to find a partner team for part 6b (VPC Peering)

**Learning Objectives:**
- Understand VPC networking fundamentals (subnets, internet gateways, route tables)
- Launch and configure EC2 instances
- Configure security groups for network access control
- Establish VPC peering connections between AWS accounts
- Monitor EC2 instances using CloudWatch
- Implement infrastructure-as-code using Terraform

## 2. Prerequisites

Before starting this lab, ensure you have the following installed and configured:

- **GitHub Account with SSH Authentication**
- **WSL (Windows only)**: If you're on Windows, install Windows Subsystem for Linux (WSL) and use a Linux distribution (Ubuntu recommended)
- **Git**: Install Git and configure it with your name and email
- **Terraform**: Install Terraform (version 1.14 or later)
- **Visual Studio Code**: Install VS Code with recommended extensions:
  - Git Graph

## 3. Introduction

This lab is divided into two main parts:

**Part 1: Manual Configuration**
You will manually configure AWS resources through the AWS Console to understand the underlying concepts:
1. VPCs in AWS
2. EC2 instance and public connectivity
3. Nginx web servers
4. VPC peering and private connectivity
5. Monitoring of Cloud resources

**Part 2: Infrastructure as Code**
You will recreate your infrastructure from the previous steps using Terraform.


## Part 1: Manual Configuration

### 1. Configuring your VPC

In this section, you will create a VPC with a public subnet and internet gateway.


### 2. Launch Your EC2

In this section, you will launch an EC2 instance in your public subnet and configure a web server.


#### Step 2.3: Configure nginx Using Session Manager

1. Wait for your instance to be in "Running" state
2. Select your instance and click "Connect"
3. Choose "Session Manager" tab
4. Click "Connect" (this will open a browser-based terminal)
5. Once connected, run the `scripts/bootstrap-nginx.sh` script to configure a web server in your EC2 instance.


### 3. Reach Your Web Server

#### Step 3a: Access via Public IP

1. In the EC2 Dashboard, select your instance
2. Copy the **Public IPv4 address** from the instance details
3. Open a web browser and navigate to: `http://<your-public-ip>`
4. You should see your welcome page

#### Step 3b: Create VPC Peering Connection with Partner Team

1. **Coordinate with your partner team**:
   - Exchange VPC IDs
   - Confirm CIDR blocks don't overlap
   - Decide who will be the "requester" and "accepter"

2. **If you are the requester**:
   - Navigate to VPC Dashboard → "Peering Connections"
   - Click "Create peering connection"
   - **Name**: `lab1-peer-to-partner`
   - **VPC (Requester)**: Select your VPC
   - **Account**: Select "Another account"
   - **Account ID**: Enter your partner's AWS account ID
   - **VPC (Accepter)**: Enter your partner's VPC ID
   - Click "Create peering connection"
   - Share the peering connection ID with your partner

3. **If you are the accepter**:
   - Wait for your partner to create the peering connection
   - Navigate to VPC Dashboard → "Peering Connections"
   - Find the pending peering connection
   - Select it and click "Actions" → "Accept request"
   - Confirm the acceptance

4. **Update Route Tables** (both teams):
   - Navigate to "Route Tables"
   - Select the route table for your public subnet
   - Click "Edit routes"
   - Add a route:
     - **Destination**: Partner team's VPC CIDR block
     - **Target**: Select the peering connection
   - Click "Save changes"

5. **Test connectivity**:
   - From your EC2 instance (accessed by Sessions Manager), try to ping or curl your partner's **private IP**

**Note**: VPC peering works with private IPs, not public IPs. You'll need to use the private IP addresses for communication between peered VPCs.

### 4. Monitor Your EC2

In this section, you will monitor your EC2 instance using CloudWatch.

#### Step 7.1: View CPU Utilization

#### Step 7.2: Create CloudWatch Alarm for High CPU Usage




## Part 2: Infrastructure as Code

In this section, you will recreate your infrastructure using Terraform, learning infrastructure-as-code principles.

### 1. Bootstrap Your Git Repository


### 2. Set Up State Bucket for Terraform


### 3. Develop Your Solution Using Terraform



## Extra Credit

### Extra Credit 1: Set Up CloudWatch Agent

The CloudWatch Agent provides more detailed metrics than the default EC2 metrics.


### Extra Credit 2: Connect to your EC2 Instance through SSH


## Resources

- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [CloudWatch Documentation](https://docs.aws.amazon.com/cloudwatch/)
- [EC2 User Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/)

## Submission

You will need to create one lab report per team. At the bare minimum, it should include:
1. Names and student numbers of team members
2. Screenshots of your working web server (public IP access)
3. Screenshot of VPC peering connection status
4. Screenshot of connectivity with your partner team through private IP
5. Screenshot of CloudWatch alarm configuration
6. Link to your GitHub repository with Terraform code
