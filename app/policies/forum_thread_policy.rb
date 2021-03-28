class ForumThreadPolicy < ApplicationPolicy
    def edit? # Apa boleh edit?
        # record adalah objek dari ForumThread, dan diambil id pembuat nya dengan id user yang login
        user.id == record.user.id || user.admin? 
    end

    def update?
        user.id == record.user.id || user.admin?
    end

    def destroy?
        user.admin?
    end
end