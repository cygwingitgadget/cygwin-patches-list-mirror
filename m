Return-Path: <cygwin-patches-return-4958-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21785 invoked by alias); 12 Sep 2004 19:53:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21776 invoked from network); 12 Sep 2004 19:53:41 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Sun, 12 Sep 2004 19:53:00 -0000
In-Reply-To: <20040912144258.GB11786@cygbert.vinschen.de>
       from Corinna Vinschen (Sep 12,  4:42pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-Id: <20040912195340.946BCE538@carnage.curl.com>
X-SW-Source: 2004-q3/txt/msg00110.txt.bz2

> But native apps are not our first concern ...

OK, but native apps are a big concern for us (and perhaps others).
We use ...

    ssh build-server-running-cygwin "make everything" > log-file

... and the Makefiles run lots of win32 native build tools.

> ...  and the above can also easily be done with
> 
> ssh -t cygwin-system-with-sshd-using-sockpairs "win32-native-command"

Allocating a pty does change the behavior of some programs, like ls.
People (or scripts) might be surprised by the behavior of ...

  ssh -t cygwin-system ls | grep whatever

... because ls is going to do multi-column output.

Also, I wonder about the performance impact of allocating a pty.
Probably minimal compared to the ssh authentication stuff, but
it would be nice to avoid the extra mechanism when it's not needed.

--
Bob
