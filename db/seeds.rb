User.destroy_all
u = User.new
u.email = "aplatteeuw@outlook.fr"
u.password = "123456"
u.password_confirmation = "123456"
u.save!
