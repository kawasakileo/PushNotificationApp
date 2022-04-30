# Levantamento do Push Notification  
  
-- çjkfçlzsjflsjflks

De acordo a CNCT-292.  
  
## Parte do app  [[1]](https://pub.dev/packages/firebase_messaging)
  
* Criar o app com um widget simples 
* Importar pacotes do Firebase em arquivos do app
* Adicionar no android/app/src/main/AndroidManifest.xml:
`<intent-filter>
    <action android:name="FLUTTER_NOTIFICATION_CLICK" />
    <category android:name="android.intent.category.DEFAULT" />
</intent-filter>`
* O arquivo do widget deve conter também:
`import 'package:firebase_messaging/firebase_messaging.dart;`
`final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();`

## Parte do Firebase

* Criar um projeto no console do Firebase
* Ir até: "Ampliar" > "Cloud Messaging" > "Nova Notificação":
  * Em "Notificação", colocar o título e o texto da notificação 
  * Em "Segmentação", selecionar "Segmentação do Usuário" e depois selecionar o projeto
  * Em "Outras Opções", adicionar nos campos: click_action e  FLUTTER_NOTIFICATION_CLICK
* Para disparar a notificação: Revisar > Publicar

## Utilizando API Rest (Postman) [[2]](https://firebase.google.com/docs/cloud-messaging/http-server-ref#downstream-http-messages-json  ) [[3]](https://firebase.google.com/docs/cloud-messaging/http-server-ref#device-group-managmement) 
* Para disparar uma notificação via API Rest deve-se utilizar um token do aparelho. Ele pode ser gerado ao iniciar o app e printado no console, como é feito no código deste repositório. 
* Endpoint (Post): https://fcm.googleapis.com/fcm/send
* Headers: 
	* Authorization: key= <<abc>chave-do-servidor>*
	* Content-Type: application/json
	
*<<abc>chave-do-servidor>: Projeto Firebase > Settings > CloudMessaging > Chave do Servidor

![image](https://user-images.githubusercontent.com/54816694/87586298-b74f5a80-c6b6-11ea-9cd1-732d76413fd6.png)

#### Enviando para um aparelho

* Body para um aparelho:
  * Raw JSON:
`{
    "to": <token-gerado>,
    "notification": {
        "title": "Notificação Postman",
        "body": "Essa é uma notificação via Postman"
    }
}`
  * Deve ser retornado (status: 200):
`{
    "multicast_id": 2433826557469636659,
    "success": 1,
    "failure": 0,
    "canonical_ids": 0,
    "results": [
        {
            "message_id": "0:1594766569111265%b55a18a9f9fd7ecd"
        }
    ]
}`
-------------------------------------------------------------------------
#### Enviando para múltiplos aparelhos (1 até 1000)

* Body para múltiplos aparelhos:
  * Raw JSON: 
`{
    "registration_ids": [
        <token-gerado-aparelho-1>,
        <token-gerado-aparelho-2>,
        <token-gerado-aparelho-n>
    ],
    "notification": {
        "title": "Notificação Postman",
        "body": "Notificação via Postman com 'registration_ids' 3 itens"
    }
}`

![image](https://user-images.githubusercontent.com/54816694/87586298-b74f5a80-c6b6-11ea-9cd1-732d76413fd6.png)

  * Deve ser retornado (status: 200): 
`{
"multicast_id": 2923972752829836935,
"success": 3,
"failure": 0,
"canonical_ids": 0,
"results": [
{
"message_id": "0:1594829131557133%b55a18a9b55a18a9"
},
{
"message_id": "0:1594829131564905%b55a18a9b55a18a9"
},
{
"message_id": "0:1594829131551071%b55a18a9b55a18a9"
}
]
}`
---------------------------------------------------------------------------------
#### Criação de grupos 

* Enviar notificações para grupos deve ser mais ágil do que enviar usando um array com vários IDs.
* Endpoint (Post): https://fcm.googleapis.com/fcm/notification 
* Adicionar aos Headers: project_id: <código-remetente>*

![image](https://user-images.githubusercontent.com/54816694/87586688-452b4580-c6b7-11ea-82a2-1688d107ec92.png)

*<código-remetente>: Projeto Firebase > Settings > CloudMessaging > Código do Remetente

* Body para criação de grupos:
  * Raw JSON:
`{
"operation": "create",
"notification_key_name": "nomeDoGrupo",
"registration_ids": [
<token-gerado-aparelho-1>, <token-gerado-aparelho-2>, <token-gerado-aparelho-n>
]
}`
  * Deve ser retornado um valor que será o token relativo a esse grupo:
  `{
"notification_key": "APA91bFh_xMpRlgb9Urw1fVLpc8zgQ9ExJL4synIa0v_ZnnDRg1e0rSMnIhJ39kuyMXQ1qeoWwig7lpbl8LGTGdluWAQHHLeVIiJb0RWHzlol2Ms-XP508Y"
}`

![image](https://user-images.githubusercontent.com/54816694/87586825-8ae80e00-c6b7-11ea-9b1d-9424a2079eae.png)

----------------------------------------------------------------------------

#### Enviando para grupos

* Não é necessário o "project_id" nos Headers.
* Body para enviar para grupos:
  * `{
"to":"<notification-key-gerado>": {
"title": "Notificação Postman",
"body": "Utilizando 'to' com valor 'notification_key'"
}
}`

![image](https://user-images.githubusercontent.com/54816694/87586884-b10dae00-c6b7-11ea-8d20-f46dfb3790c4.png)

  * Deve ser retornado (status: 200):
`{
"success": quantidade de sucessos,
"failure": quantidade de falhas
}`

![image](https://user-images.githubusercontent.com/54816694/87586752-6a1fb880-c6b7-11ea-9878-a17c4c1fd863.png)

--------------------------------------------------------------------------------
  
### Referências: 
[1] https://pub.dev/packages/firebase_messaging  
[2] https://firebase.google.com/docs/cloud-messaging/http-server-ref#downstream-http-messages-json  
[3] https://firebase.google.com/docs/cloud-messaging/http-server-ref#device-group-managmement