import { AppPermissionName } from '@prisma/client';
import prisma from '../prisma/client';
import { AppError, AppErrorName } from './AppError';

class PermissionError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'PermissionError';
    }
}

export const checkUserPermission = async (
    userId: number,
    organizationId: number,
    requiredPermission: AppPermissionName
): Promise<boolean> => {
    try {
        // Get the user's role in the organization
        const userRole = await prisma.userOrganizationRole.findFirst({
            where: { userId, organizationId },
        });

        if (!userRole) {
            // The user is not a member of the organization
            return false;
        }

        // Retrieve the role-based permissions
        const rolePermissions =
            await prisma.organizationRolePermission.findMany({
                where: { roleId: userRole.roleId },
                select: { permission: { select: { permissionName: true } } },
            });

        // Check if the required permission matches any of the role permissions
        const hasPermission = rolePermissions.some(
            (rolePermission) =>
                rolePermission.permission.permissionName === requiredPermission
        );

        return hasPermission;
    } catch (error: any) {
        throw new AppError(
            AppErrorName.PRISMA_ERROR,
            `Error saving file to database: ${error.message}`,
            500,
            true
        );
    }
};
