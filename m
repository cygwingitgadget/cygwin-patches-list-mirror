Return-Path: <cygwin-patches-return-2143-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18790 invoked by alias); 2 May 2002 18:12:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18776 invoked from network); 2 May 2002 18:12:04 -0000
Message-ID: <3CD18018.1C534F7@email.byu.edu>
Date: Thu, 02 May 2002 11:12:00 -0000
From: Eric Blake <ebb9@email.byu.edu>
Organization: BYU Student
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Patch: Re: Bug in stat()?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00127.txt.bz2

Is this the right list for this patch?  I feel like I was writing to
/dev/null with the main cygwin list, as no one has responded to this thread.

-------- Original Message --------
From: Eric Blake <ebb9@email.byu.edu>
Subject: Patch: Re: Bug in stat()?
To: cygwin@cygwin.com
CC: Eric Blake <ebb9@email.byu.edu>

Eric Blake wrote:
> 
> I am running into weird behavior with stat().  I am getting the same
> st_ino number for two distinct directories.  When using the jikes
> compiler on the GNU Classpath project (the upstream source of libjava in
> gcc), jikes is keying off of the inode number to determine where to
> write .class files.  Because the inode number is a duplicate, jikes is
> making the wrong choice, and then failing to compile.
> 

After some poking around, I see that stat() fills in st_ino using a hash
function on the absolute file name (since Windows does not understand the
concept of inodes).  I confirmed that there is a bug in the hashing function
- it is not a strong enough hash.  The culprit is in winsup/cygwin/path.cc,
in hash_path_name().

My updated demonstration follows.  Notice that it is sensitive to the
directory you run it in; while there are certainly other directories that
would show this problem, the bug does not surface in all directories.

$ cygpath -aw `pwd`
d:\cygwin\home\eblake\cp\lib
$ cat blah.java
#include <sys/stat.h>
#include <stdio.h>
int main(int argc, char** argv)
{
  /* Print results obtained from cygwin */
    struct stat status;
    int result;
    result = stat("./java", &status);
    printf("./java (%d): %x, %x\n", result, status.st_dev, status.st_ino);
    result = stat("./java/net", &status);
    printf("net (%d): %x, %x\n", result, status.st_dev, status.st_ino);
    result = stat("./java/nio", &status);
    printf("nio (%d): %x, %x\n", result, status.st_dev, status.st_ino);

  /* morph from "./java" to "./java/net" */
    unsigned int hash = 0x210fd907;
    printf("%x\n", hash);
    int ch = '\\';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    ch = 'n';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    ch = 'e';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    ch = 't';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n\n", hash);

  /* morph from "./java" to "./java/nio" */
    hash = 0x210fd907;
    printf("%x\n", hash);
    ch = '\\';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    ch = 'n';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    ch = 'i';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    ch = 'o';
    hash += ch + (ch << 17);
    hash ^= hash >> 2;
    printf("%x\n", hash);
    return 0;
}
$ ./blah.exe
./java (0): 1000, 210fd907
net (0): 1000, 20a2ae8b
nio (0): 1000, 20a2ae8b
210fd907
29b62f3b
2036a443
29408d82
20a2ae8b

210fd907
29b62f3b
2036a443
294a8d87
20a2ae8b



Notice that from the inode hash of ./java, with cwd of
d:\cygwin\home\eblake\cp\lib, I was able to match the inode hash of both
./java/net and ./java/nio using the two lines
      hash += ch + (ch << 17);
      hash ^= hash >> 2;
from path.cc.  The two hashes are different after "\\ne" and "\\ni", but
converge again when appending 't' and 'o' respectively.

I'm not a hashing expert, but I suggest that you try the hashing algorithm
used in the Java programming language for java.lang.String.hashCode(), as
shown in my patch below.  I think it is a stronger hash, and I know that it
would solve my problem, with less computation per character.

2002-04-30  Eric Blake  <ebb9@email.byu.edu>

	* path.cc (hash_path_name): Improve hash function strength.

$ diff -u path.cc.bak path.cc
--- path.cc.bak Tue Apr 30 16:32:52 2002
+++ path.cc     Tue Apr 30 16:40:14 2002
@@ -3136,7 +3136,7 @@
          hash = cygheap->cwd.get_hash ();
          if (name[0] == '.' && name[1] == '\0')
            return hash;
-         hash += hash_path_name (hash, "\\");
+         hash = (hash << 5) - hash + '\\';
        }
     }

@@ -3146,8 +3146,7 @@
   do
     {
       int ch = cyg_tolower(*name);
-      hash += ch + (ch << 17);
-      hash ^= hash >> 2;
+      hash = (hash << 5) - hash + ch;
     }
   while (*++name != '\0' &&
         !(*name == '\\' && (!name[1] || (name[1] == '.' && !name[2]))));

-- 
This signature intentionally left boring.

Eric Blake             ebb9@email.byu.edu
  BYU student, free software programmer
