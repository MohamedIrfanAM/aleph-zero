const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function getUserData(username) {
    try {
        const userData = await prisma.users.findUnique({
            where: { user_name: 'irfan' },
            select: {
                name: true,
                user_name: true,
                phoneNo: true,
                email: true,
                profile_pic: {
                    select: { url: true },
                },
                college: {
                    select: { name: true, branches: { select: { name: true } } },
                },
                location: true,
            },
        });

        console.log('User Data:', userData);
    } catch (error) {
        console.error('Error retrieving user data:', error);
    } finally {
        await prisma.$disconnect(); // Disconnect the Prisma client
    }
}

getUserData('desired_username');
