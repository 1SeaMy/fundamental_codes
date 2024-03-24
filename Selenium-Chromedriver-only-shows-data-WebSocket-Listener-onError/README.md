# Selenium-Chromedriver-only-shows-data-WebSocket-Listener-onError
Try this code.



        ChromeOptions options =new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");
        options.addArguments("--disable notifications");
        DesiredCapabilities cp=new DesiredCapabilities();
        cp.setCapability(ChromeOptions.CAPABILITY, options);
        options.merge(cp);

        WebDriver driver=new ChromeDriver(options);
        driver.manage().window().maximize();
        driver.get("https://google.com");
