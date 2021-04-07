# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = Usuari.new(email: 'david@email.com', password: '', password_confirmation: 'nomatch')
user.save                                                  # => false, password required
user.password = 'mUc3m00RsqyRe'
user.save                                                  # => false, confirmation doesn't match
user.password_confirmation = 'mUc3m00RsqyRe'
user.save                                                  # => true
user.authenticate('notright')                              # => false
user.authenticate('mUc3m00RsqyRe')                         # => user
Usuari.find_by(name: 'david')&.authenticate('notright')      # => false
Usuari.find_by(name: 'david')&.authenticate('mUc3m00RsqyRe') # => user
