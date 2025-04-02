package put.poznan.sport;

//import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class  SportApplication {

    public static void main(String[] args) {
        // Pobieranie zmiennych środowiskowych za pomocą System.getenv()
        String dbUrl = System.getenv("DB_URL");
        String dbUsername = System.getenv("DB_USERNAME");
        String dbPassword = System.getenv("DB_PASSWORD");

        // Ustawienie zmiennych jako właściwości systemowe (opcjonalne, jeśli potrzebujesz)
        System.setProperty("DB_URL", dbUrl);
        System.setProperty("DB_USERNAME", dbUsername);
        System.setProperty("DB_PASSWORD", dbPassword);

        // Uruchomienie aplikacji
        SpringApplication.run(SportApplication.class, args);
	}
}


