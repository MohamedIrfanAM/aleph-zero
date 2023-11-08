import { getServerSession } from "next-auth";
import CredentialsProvider  from "next-auth/providers/credentials"
import prismadb from "@/lib/prismadb"
import { compare } from "bcryptjs"

export const authOptions = {
    providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {},
      async authorize(credentials, req) {
        const user = await prismadb.Users.findUnique({
          where: {
            email: credentials.email
          }
        })
        if (user) {
          const isValid = await compare(credentials.password, user.password)
          if(user.verified === false){
            throw Error("Not Activated")
          }
          if(isValid){
            return user;
          }
          else{
            throw Error("Invalid Password")
          }
        } else {
          throw Error("Invalid Email")
        }

      }
    }),
  ],
  secret: process.env.NEXTAUTH_SECRET,
  session:{
    strategy: "jwt",
  },
  pages: {
    signIn: "/login",
    error: "/auth/error",
    verifyRequest: "/login",
    newUser: "/signup"
  },
  callbacks: {
    jwt(params){
      if(params.user?.username){
        params.token.username = params.user.username;
        params.token.email = params.user.email;
      }
      return params.token;
    },
    session({session, token}){
      session.user.username = token.username;
      session.user.email = token.email;
      return session;
    }
  }
}


const useServerSession = () => getServerSession(authOptions)
export default useServerSession