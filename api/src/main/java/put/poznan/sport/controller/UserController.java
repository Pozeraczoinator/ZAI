package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.User.UserDTO;
import put.poznan.sport.entity.User;
import put.poznan.sport.service.user.UserService;

@RestController
@RequestMapping("api/user/")
public class UserController {

    @Autowired
    private UserService userService;

   @GetMapping
   @ResponseBody
   public ResponseEntity<?> getUser() {
        return new ResponseEntity<>(userService.getUser(), HttpStatus.OK);
   }

   @PutMapping("update")
   @ResponseBody
    public ResponseEntity<?> updateUser(@RequestBody UserDTO user) {
        return new ResponseEntity<>(userService.updateUser(user), HttpStatus.OK);
   }
    @DeleteMapping("delete")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteUser() {
        userService.deleteUser();
    }
}
