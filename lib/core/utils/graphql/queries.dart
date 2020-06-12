String signUp(String email, String password) =>
    'mutation{createUser(userInput: {email: "$email", password: "$password"}) {_id,email, }}';

String login(String email, String password) =>
    'query{login(email:"$email", password:"$password"){userId,token,tokenExpiration}}';
