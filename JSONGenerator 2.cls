{
    class comment {
      Integer postId;
      Integer id;
      String email;
      String body;
    
      comment() {
        postId = null;
        id = null;
        email = null;
        body = null;
      }
    
      comment(Integer p, Integer i, String e, String b) {
        postId = p;
        id = i;
        email = e;
        body = b;
      }
    }
    
    List<comment> commentList = new List<comment>();
    for (Integer i=0,j=0; i<500; i++) {
        comment c = new comment(
            1,
            ++j,
            'foobar.' + j + '@apextest.com',
            'ut dolorum nostrum id quia aut est (' + j + ').'
        );
        commentList.add(c);
    }
    
    final Boolean pretty = true;
    final Boolean plain = false;
    JSONGenerator jsonGen = JSON.createGenerator(pretty);
    jsonGen.writeObject(commentList);
    jsonGen.close();
    System.debug(jsonGen.getAsString());
}
