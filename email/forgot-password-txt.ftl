[#setting url_escaping_charset="UTF-8"]
[#-- The optional 'state' map provided on the Forgot Password API call is exposed in the template as 'state' --]
[#assign domain = "{ENTER DOMAIN HERE}" /]
[#assign url = "https://${domain}/app/fa-reset/${changePasswordId}?tenantId=${user.tenantId}" /]
[#list state!{} as key, value][#if key != "tenantId" && value??][#assign url = url + "&" + key?url + "=" + value?url/][/#if][/#list]

You are receiving this email because you have requested to change your password on Permanent.org. Follow the link below to reset your password:

${url}

This link will expire in 1 hour.

If you didn’t make this request, ignore this email. If you believe an unauthorized person has accessed your account, please contact us immediately at support@permanent.org or simply reply to this email. Then, please change your password by signing in at https://www.permanent.org/app.


---
You are receiving this automated system notification because you are a registered user of Permanent.org. You can update your notification preferences in your account settings. If you believe you are receiving these emails in error or you require further assistance, please contact our Customer Support team at support@permanent.org or reply to this email.
