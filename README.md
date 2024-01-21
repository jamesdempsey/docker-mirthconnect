This Dockerized version of Mirth Connect is configured to run behind nginx on the [Aptible](https://www.aptible.com/) platform.

Build the image and run locally with the following commands:

     docker run --rm -i -t -p 3000:3000 -p 9661:9661 -p 9662:9662 -e MIRTH_ADMIN_PW=PASSWORD IMAGE_NAME

You can launch Mirth Connect Administrator by visiting `boot2docker ip`. The default username is admin and the password is set via the MIRTH\_ADMIN\_PW environment variable above. Port 9661 is exposed using the above commands.

You should see the test channel deployed and running on the dashboard view.

To test that this is working, you'll need a tool like [HL7 Inspector](https://bitbucket.org/crambow/hl7inspector/wiki/Home)

Download some [sample HL7 messages](https://www.hl7.org/implement/standards/product_brief.cfm?product_id=228)

Import the ADT\_A01.xsd sample HL7 message in Inspector and open the Message Sender pane. Open Send Options and change the Host/Port to DOCKER_IP:9661

Highlight the message and click Send. You should see an Acknowledge message in the pane below and the message statistics should increase in Mirth Connect Administrator.
