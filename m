From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Re: a weird behavior on a command prompt.
Date: Wed, 13 Sep 2000 13:35:00 -0000
Message-id: <s1szolchw0p.fsf@jaist.ac.jp>
References: <s1s66o0jnd3.fsf@jaist.ac.jp> <20000913142841.C17331@cygnus.com> <s1s3dj4je7c.fsf@jaist.ac.jp> <20000913155221.A26441@cygnus.com>
X-SW-Source: 2000-q3/msg00088.html

I'm sorry. I completely misunderstood your mail.
But I have to point out that the result of strcpy between
overlapped regions is unpredictable according to the standard.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
