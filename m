Return-Path: <cygwin-patches-return-2927-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9795 invoked by alias); 3 Sep 2002 15:36:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9781 invoked from network); 3 Sep 2002 15:36:00 -0000
Message-ID: <3D74D6D0.7080007@netscape.net>
Date: Tue, 03 Sep 2002 08:36:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <s1selceuumv.fsf@jaist.ac.jp> <3D720D1F.37080487@yahoo.com> <s1sbs7hvijp.fsf@jaist.ac.jp> <20020903142809.B12899@cygbert.vinschen.de> <3D74BD4A.80403@netscape.net> <20020903171937.F12899@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00375.txt.bz2

Corinna Vinschen wrote:

>On Tue, Sep 03, 2002 at 09:46:50AM -0400, Nicholas Wourms wrote:
>
>>I'd like to voice a small objection to this practice of adding and then 
>>removing symbols, especially given the quantity in this case and the 
>>period of time which lapsed inbetween.  I don't think this practice 
>>should be encouraged at all because it can be quite a PITA if you have 
>>apps which were compiled when the symbols were exported.  I think this 
>>goes double for "cosmetic" issues which are going to be fixed anyhow in 
>>the near future.  I'm trying to help Conrad test the cygserver, so I 
>>have many apps I'm using for testing purposes.  I am now going to have 
>>to recompile the ones I just compiled the other day due to this change. 
>>
>
>That's the reason I copy only the new built DLL to my "Cygwin test and
>native build system", and *not* the libcygwin.a.  This way, I link always
>against the symbols available in the latest stable release and not
>against symbols only available in the developers snapshot (except I
>really, really want it).
>
I guess in retrospect I should have taken this approach.  The only 
reason I hadn't in the past is because I thought Chuck's statements 
represented the "party-line" of this project.  Oh well, live and learn.

Cheers,
Nicholas
