# Sky rewards service

This has been implemented using the SOA pattern, with the rewards service being
a stand alone web service.  The service can be access via http at the path:

    /rewards/<account number>?portfolio=[<channel>,..]
    
It is expected that the Eligibility service will be implemented using a similar pattern
and will be available at:
 
    http://<eligibility domain>/eligibile/<account number>
    
and will return string value in the body of the response containing either CUSTOMER_ELIGIBLE or 
CUSTOMER_INELIGIBLE or alternative will raise an appropriate error response code, where ```404```
will be treated as ```Invalid account number exception```.

the internal system logic will be written so that it could easily be extract into a larger system
if the architect changes from what is specified above.

