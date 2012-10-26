FactoryGirl.define do
	factory :user do
		name	"Mi usuario"
		email	"usuario@miiglesiaenlinea.com"
		churchname	"Mi Iglesia en linea"
		password 	"usuario"
		password_confirmation "usuario"
	end
end