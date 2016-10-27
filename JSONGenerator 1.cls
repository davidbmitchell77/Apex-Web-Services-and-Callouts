{
    final Boolean pretty = true;
    final Boolean plain = false;
    JSONGenerator jsonGen = JSON.createGenerator(pretty);
    jsonGen.writeStartArray();
    for (Integer i=0,j=0; i<500; i++) {
      jsonGen.writeStartObject();
      jsonGen.writeNumberField('postId', 1);
      jsonGen.writeNumberField('id', ++j);
      jsonGen.writeStringField('name', 'foobar ' + j);
      jsonGen.writeStringField('email', 'foobar.' + j + '@apextest.com');
      jsonGen.writeStringField('body', 'ut dolorum nostrum id quia aut est (' + j + ').');
      jsonGen.writeEndObject();
    }
    jsonGen.writeEndArray();
    jsonGen.close();
    System.debug(jsonGen.getAsString());
}
