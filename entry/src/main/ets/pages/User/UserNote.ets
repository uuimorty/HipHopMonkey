import UserLayout from '../../components/UserLayout'

@Component
struct UserNote {
  build() {
    UserLayout()
  }
}

@Builder
function UserNotesBuilder() {
  UserNote()
}