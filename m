Return-Path: <cygwin-patches-return-3405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29523 invoked by alias); 15 Jan 2003 20:19:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29514 invoked from network); 15 Jan 2003 20:19:26 -0000
Message-ID: <3E25C2DB.7060808@ece.gatech.edu>
Date: Wed, 15 Jan 2003 20:19:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Where to put my basename() and dirname() implementation...
References: <59A835EDCDDBEB46BC75402F4604D5528F75D6@elmer> <009201c2bcc0$82411040$305886d9@webdev> <20030115183034.GH15975@redhat.com>
In-Reply-To: <59A835EDCDDBEB46BC75402F4604D5528F75D6@elmer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2003-q1/txt/msg00054.txt.bz2

Christopher Faylor wrote:

>
> I don't want to add any more libiberty routines to cygwin since the
> licensing is suspect.  So, please follow the normal submission rules.
> Probably miscfuncs.cc is the place to add this.
>

That make sense.  Unlike many of the other functions in libiberty, The 
basename() function itself in libiberty/basename.c is public domain -- 
which may be good for our purposes, or it may be bad (I dunno, and cgf 
has already made the call: it's "suspect". Fair enough.)  In any case, 
it does no harm to have "our" own version that can be copyright-assigned 
to Red Hat and distributed under the Cygwin license.

--Chuck


