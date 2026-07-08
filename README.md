# terraform-azure-aks

Primero creamos un service principal con el comando

```sh
az ad sp create-for-rbac --name myAKSClusterServicePrincipal
```

esto nos dará algo como:

```json
{
  "appId": "",
  "displayName": "",
  "password": "",
  "tenant": ""
}
```

Luego tenemos que crear un ID secreto para autorizar y autenticarnos a los servicios de azure

```sh
az ad app credential reset --id <appId>
```

Esto generará una salida como esta:

```json
{
  "appId": "",
  "password": "",
  "tenant": ""
}
```

Comando para importar:

```sh
terraform import azurerm_virtual_network.vnet-aks-admision /subscriptions/...81/resourceGroups/aks-admision/providers/Microsoft.Network/virtualNetworks/aks-admision-vnet
```

Ejecutar normalmente

```sh
terraform init
terraform plan
terraform apply
```

Para conectarse

```sh
az aks get-credentials --resource-group aks-admision --name k8stest
```

Listo!
