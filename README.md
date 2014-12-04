Build the image and run with the following command:

     docker run -p 8080:8080 -p 8443:8443 -p 6661:6661 IMAGE_NAME

You can launch Mirth Connect Administrator by visiting <docker ip>:8080

The default username and password are admin/admin

You should see the test channel deployed and running on the dashboard view.

To test that this is working, you'll need a tool like [HL7 Inspector](http://sourceforge.net/projects/hl7inspector/)

Download some [sample HL7 messages](http://www.hl7.org/implement/standards/product_brief.cfm?product_id=228)

Import the ADT_A01.xsd sample HL7 message in Inspector and open the Message Sender pane. Open Send Options and change the Host/Port to <docker ip>:6661

Highlight the message and click Send. You should see an Acknowledge message in the pane below and the message statistics should increase in Mirth Connect Administrator.
