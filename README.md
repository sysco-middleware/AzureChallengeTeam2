# AzureChallengeTeam2

Actual Task: 
The first version (large VNET) of the solution should have:
-    A running App Service Environment (ASE)
-    An App Service Plan on tier I1v2
-    An Azure Function and a Logic App running on this App Service Plan (both on same)
-    Deployment set up in Azure Devops
-    Deploy a simple demo API in the Azure Function
-    The HTTP endpoints should not be accessible from outside the network
 

Version two (small VNET) needs to add:
-    A separate VNET with peering to the previous on
-    API Management on tier Developer
-    Application Gateway with Web Application firewall
-    Allow traffic to Function app through Application Gateway and API Management only from location specified (Cegal office)

IMPORTANT: 

- The ASE and App Service Plan are the most expensive resources, please don’t create more than one and don’t let them run for too long.
- And for API Management, only 2 tiers support network isolation, Developer and Premium. Developer is almost for free, Premium cost 25000 NOK per month, choose Developer.


Plan ?? 

Step 1: Oraganization.
    - Create RGs
        - Network
        - App
        - Mgmt (storage bucket & .tfstatefile)
Step 2: Network
    - Network RG (part of task version2)
        - Create network resource
            - 2 vNets (Hub (WAF / API Gateway) to App) with peering
            - NSG to allow traffic between vNets
            - Create WAF & API Gateway (use Developer tier)
    - App RG (part of task version1)
Step 3: Compute
    - Create the compute resources:
            - App Service Plan (tier I1v2)
            - App service
            - Function APP
Step 4: (part of task version1)
    - DevOps Pipeline


# Terraform

# What you are doing - List of steps
1.
2.
3.

## Requirements and install instructions

1. Running Terraform:

* terraform init
* terraform validate
* terraform plan !! Remember to review the plan !!
* terraform apply

## Removal of stack
In case you want to remove created resources:
* terraform destroy

## Additional notes

You can freely change the variables in the variables.tf depending what you need. One could potentially try different amount of servers by adding new instance names. Try and test!






