From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: rename() doesn't set the errno properly.
Date: Sat, 10 Mar 2001 12:15:00 -0000
Message-id: <s1s3dclqux8.fsf@jaist.ac.jp>
X-SW-Source: 2001-q1/msg00164.html

rename() doesn't set the errno when an old path doesn't exist.
The following patch can solve this problem.
