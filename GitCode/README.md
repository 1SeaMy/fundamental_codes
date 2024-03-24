1- Create = lRepo and rRepo <p>
git init<br>
git add .<br>
git commit -m "GitCode 01"<br>
git branch -M main<br>
git remote add origin https://github.com/1SeaMy/GitCode.git<br>
git push -u origin main<p>

2- Change = 1 + working + later merge<p>
git add .<br>
git commit -m "GitCodeChange01"<br>
git push<p>

3- Pull = Other repo download<p>
git init<br>
git pull https://github.com/1SeaMy/XXX.git<p>

4- Push = 3 + working + create rRepo + later merge<p>
git add .<br>
git commit -m "GitCodeChange02"<br>
git branch -M main<br>
git remote add origin https://github.com/1SeaMy/XXX.git<br>
git push -u origin main<p>

5- Pull = mistake, delete lRepo, create lRepo<p>
git init<br>
git pull https://github.com/1SeaMy/XXX.git<br>
git branch -M main<br>
git remote add origin https://github.com/1SeaMy/GitCode.git<br>
git push -u origin main<p>
