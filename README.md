# Watch Faces
My goal was to create personalized watch faces for the Garmin Forerunner 55, which features a transflective 8-bit display optimized for outdoor visibility and low power consumption.

To streamline development, I used the Connect IQ SDK to virtually emulate the watch, allowing me to test and debug watch faces without needing the physical device at every step.

All coding was done in Garmin’s MonkeyC programming language, a specialized language designed for Connect IQ apps and watch faces. MonkeyC combines concepts from several programming languages, including Java, JavaScript, and Python, providing a familiar syntax while being optimized for low-power wearable devices and small, high-performance screens.

Using this setup, I was able to experiment with custom fonts, color schemes, and dynamic elements, creating watch faces that are both functional and visually appealing on the FR55’s limited 208×208 pixel display.

## First Design: Retro 8-bit
My first design idea was inspired by old-school 8-bit color command-line terminals, featuring bold, contrasting colors and pixelated graphics. I aimed to capture the retro digital aesthetic while adapting it to the Forerunner 55’s limited display.   

<img width="387" height="611" alt="image" src="https://github.com/user-attachments/assets/74ee785a-263b-4c81-918d-9512cc974961" /> <img width="402" height="603" alt="image" src="https://github.com/user-attachments/assets/b848b133-ec53-41de-ab05-3d72a9a354d8" />  

<img width="826" height="509" alt="image" src="https://github.com/user-attachments/assets/90edd5d1-9889-4d85-b618-7b1bddd83b4e" />  

I really liked how this simple watch face turned. It was clean, colorful, and easy to read. However, it also lacked functionality beyond simply showing the time. To make it more useful, I decided to transform the eight colorful squares into a dynamic bar-chart display, where each color represents a different type of data. I switched out the "Hellow World" text for the day and date.

<img width="387" height="611" alt="image" src="https://github.com/user-attachments/assets/405cda87-c79e-4cff-bf01-0aaf6680c81b" /> <img width="388" height="608" alt="image" src="https://github.com/user-attachments/assets/bc0e4d9d-50ce-4bdd-bfeb-72522419f4b4" /> 

| **Colour**  |  **Data**                 |
|:--------|:------------------------------|
| `BLACK`   | -                           |
| `RED`     | heart rate                  |
| `GREEN`   | steps (% of my daily goal)  |
| `YELLOW`  | stress level                |
| `DK_BLUE` | bluetooth connection status |
| `PINK`    | battery %                   |
| `BLUE`    | body battery                |
| `WHITE`   | notifications               |

## Useful Links
- Basic tutrorial: https://medium.com/@ericbt/design-your-own-garmin-watch-face-21d004d38f99
- Codes Samples: https://starttorun.info/connect-iq-apps-with-source-code/
- SDK download: https://developer.garmin.com/connect-iq/sdk/
- Graphics docs: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics.html
