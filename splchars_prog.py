# prog on spl characters
txt="""Romeo.  Why,  such  is  love's  transgression. 
Griefs  of  mine  own  lie  heavy  in  my  breast, 
Which  thou  wilt  propagate,  to  have  it  prest 
With  more  of  thine ;  this  love  that  thou  hast  shown 
Doth  add  more  grief  to  too  much  of  mine  own. 
Love  is  a  smoke  rais'd  with  the  fume  of  sighs : 
Being  purg'd,  a  fire  sparkling  in  lovers'  eyes ; 
Being  vex'd,  a  sea  nourish'd  with  lovers'  tears ; 
What  is  it  else  ?  a  madness  most  discreet, 
A  choking  gall,  and  a  preserving  sweet. 
Farewell,  my  coz. 

Benvolio.  Soft !  I  will  go  along ; 

An  if  you  leave  me  so,  you  do  me  wrong. 

Romeo.  Tut,  I  have  lost  myself  ;  I  am  not  here : 
This  is  not  Romeo,  he's  some  other  where. 

Benvolio.  Tell  me  in  sadness  who  is  that  you  love. 

Romeo.  What,  shall  I  groan  and  tell  thee  ? 

Benvolio.  Groan  !  why,  no  ; 

But  sadly  tell  me  who. 

Romeo.  Bid  a  sick  man  in  sadness  make  his  will; 


18  ROMEO  AND  JULIET. 

Ah,  word  ill  urg'd  to  one  that  is  so  ill ! 
In  sadness,  cousin,  I  do  love  a  woman. 

Benvolio.  I  aini'd  so  near  when  I  suppos'd  you  lov'd. 

Romeo.  A  right  good  mark-man  !    And  she's  fair  I  love. 

Benvolio.  A  right  fair  mark,  fair  coz,  is  soonest  hit. 

Romeo.  Well,  in  that  hit  you  miss  :  she'll  not  be  hit 
With  Cupid's  arrow  ;  she  hath  Dian's  wit. 
And,  in  strong  proof  of  chastity  well  arm'd, 
From  love's  weak  childish  bow  she  lives  unharm'd. 
She  will  not  stay  the  siege  of  loving  . 
Nor  bide  the  encounter  of  assailing  eyes, 
Nor  ope  her  lap  to  saint-seducing  gold ; 
0,  she  is  rich  in  beauty  !  only  poor 
That,  when  she  dies,  with  beauty  dies  her  store. 

Benvolio.  Then  she  hath  sworn  that  she  will  still  live 
chaste  ? """
print("splitting txt line by line:   ",txt.split("\n"))
print("\n")
spl_chars=[]
spl_words=[]
txt1=txt.split()

countcolon=0
countsemi=0
countapostophi=0
countques=0
countdot=0

for everyword in txt1:
    if everyword==":":
        countcolon=countcolon+1
        spl_chars.append(everyword)
    elif everyword==";":
        countsemi=countsemi+1
        spl_chars.append(everyword)
    elif everyword=="?":
        countques=countques+1
        spl_chars.append(everyword)
    elif everyword==".":
        countdot=countdot+1
        spl_chars.append(everyword)
    elif "'" in everyword:
        countaphostophi=countapostophi+1
        spl_words.append(everyword)

print("spl characters are: ",spl_chars)
print("\n")
print("spl words are: ",spl_words)
print("\n")
print("countcolon: ",countcolon)
print("countsemi: ",countsemi)
print("countapostophi: ",countapostophi)
print("countques: ",countques)
print("countdot: ",countdot)





        
    
    
    

