From: DJ Delorie <dj@delorie.com>
To: fujieda@jaist.ac.jp
Cc: cygwin-patches@sources.redhat.com
Subject: Re: a weird behavior on a command prompt.
Date: Wed, 13 Sep 2000 13:36:00 -0000
Message-id: <200009132036.QAA29721@envy.delorie.com>
References: <s1s66o0jnd3.fsf@jaist.ac.jp> <20000913142841.C17331@cygnus.com> <s1s3dj4je7c.fsf@jaist.ac.jp> <20000913155221.A26441@cygnus.com> <s1szolchw0p.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00089.html

> But I have to point out that the result of strcpy between
> overlapped regions is unpredictable according to the standard.

It's entirely predictable in cygwin, because we know we'll be using
the strcpy from newlib.
