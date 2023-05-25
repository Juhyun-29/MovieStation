package com.MovieStation.biz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan("com.MovieStation")
public class MovieStationApplication {

	public static void main(String[] args) {
		SpringApplication.run(MovieStationApplication.class, args);
	}

}
