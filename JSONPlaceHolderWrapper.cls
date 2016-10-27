public class JSONPlaceHolderWrapper {
    public class Comment {
        public Integer postId {get; set;}
        public Integer id {get; set;}
        public String name {get; set;}
        public String email {get; set;}
        public String body {get; set;}
        
        public Comment(Integer p, Integer i, String n, String e, String b) {
            postId = p;
            id = i;
            name = n;
            email = e;
            body = b;
        }
    }
    public List<Comment> commentList {get; set;}
}
