Return-Path: <cygwin-patches-return-2926-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8097 invoked by alias); 3 Sep 2002 15:27:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8083 invoked from network); 3 Sep 2002 15:27:47 -0000
Message-ID: <3D74D4E4.3090102@netscape.net>
Date: Tue, 03 Sep 2002 08:27:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <s1selceuumv.fsf@jaist.ac.jp> <3D720D1F.37080487@yahoo.com> <s1sbs7hvijp.fsf@jaist.ac.jp> <20020903142809.B12899@cygbert.vinschen.de> <3D74BD4A.80403@netscape.net> <3D74CF7A.E9FFD661@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00374.txt.bz2

Earnie Boyd wrote:
> Nicholas Wourms wrote:
> 
> 
>>ready to go.  I guess this is just my 2¢ chiming in on this, so feel
>>free to disagree...
> 
> 
> That's just the way it goes for bleeding-edge.  If your needs involve a
> stable environment then use the published environment.  Otherwise, sit a be
> patient, your 2¢ just cost me $2 of time.
> 
> Earnie.
> 

Hmm, $2 isn't very much nowadays, still you should ask for 
your money back.

As for your other comments, I am well aware of what it is to 
live on the bleeding edge.  However, the arguments Chuck 
made for being careful about adding/removing symbols are 
quite pertinent to the cvs tree.  If functions are exported, 
then the person who exported those functions should be 
prepared to fix them if they are broke.  Removing the 
exports 5 days later is just plain rediculous, especially of 
some trivial matter like standards-compliance.  However, 
since I'm not as prolific with patches as others, I guess 
what I say has very little value ($2).

Cheers,
Nicholas
