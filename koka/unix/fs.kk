module fs

effect cell<a>
  fun get(): a
  fun put(a:a): ()

pub fun runState(init:a, action: () -> <cell<a>,div|e> a): <div|e> (a,a)
  var curr := init
  with handler
    return(x)   (curr,x)
    fun get()   curr
    fun put(x)  curr := x
  action()  


alias directory = list<(string, int)>
value struct inode{ino:int; loc:int}
alias dataRegion = list<(int,string)>
alias iList = list<(int,inode)>

struct fileSystem{dir: directory; ilist:iList; dreg: dataRegion; dnext: int; inext: int}

effect fileIO
  fun read(inum:int): maybe<string>
  fun write(inum:int, content:string): ()
  
effect val fail: f

fun lookup(key:int, l:list<(int, b)>): fail b
  match l
    Nil -> fail() 
    Cons((k,v), xs) -> if key==k then v else lookup(key, xs)  


fun fread(inum:int, fs:fileSystem): fail string 
  lookup(lookup(inum, fs.ilist), fs.dreg)
  
fun fwrite(inum:int, fs:fileSystem, content:string): fail ()
  ()

