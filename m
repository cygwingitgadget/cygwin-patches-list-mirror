Return-Path: <cygwin-patches-return-7872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1695 invoked by alias); 30 Apr 2013 21:54:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1682 invoked by uid 89); 30 Apr 2013 21:54:04 -0000
X-Spam-SWARE-Status: No, score=-4.9 required=5.0 tests=AWL,BAYES_00,KHOP_THREADED,RP_MATCHES_RCVD autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 30 Apr 2013 21:54:03 +0000
Received: (qmail 23344 invoked by uid 13447); 30 Apr 2013 21:54:01 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 30 Apr 2013 21:54:01 -0000
Message-ID: <51803D76.5010302@etr-usa.com>
Date: Tue, 30 Apr 2013 21:54:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
References: <20130424172039.GA27256@calimero.vinschen.de> <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx>
In-Reply-To: <20130430202737.GA1858@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00010.txt.bz2

On 4/30/2013 14:27, Christopher Faylor wrote:
> On Tue, Apr 30, 2013 at 02:09:52PM -0600, Warren Young wrote:
>>   Embedding <html> within <html> is eeevil.
>
> faq.html is a pretty simple file and it seems to work.  Are there any
> non-religious advantages to doing this?

Conceivably browsers could stop tolerating it.

Given how tolerant browsers still are, that eventuality might seem 
unlikely, but such shifts have happened.

In the early web, this was considered acceptable HTML:

     <a name="foo">
     <h1>Foobie</h1>

In older browsers, this wouldn't do anything more than let you reference 
#foo within the document.

Today's browsers, though, see an open <a> tag and treat the entire rest 
of the page as one big hyperlink.  You can get weird effects, like 
paragraphs of text highlighting with the "clicked link" color when you 
click on such a page.  To fix it, you must close the tag, so:

    <a name="foo"/>
    <h1>Foobie</h1>

That, or change from named anchors to fragment identifiers:

     <h1 id="foo">Foobie</h1>

But I won't insist that you accept the new output. :)

>> - Any comments about the other items in my FUTURE WORK section?
>> Unconditional green light, or do you want to approve them one by one?
>
> You have the right to change anything in the doc directory.  Anything
> outside of that will require approval.

The final removal of doctool requires replacing the DOCTOOL/SGML 
comments in winsup/cygwin/{path,pinfo}.cc with Doxygen comments, and 
folding most of the contents of winsup/cygwin/*.sgml into Doxygen 
comments within the relevant source files.

I haven't deeply looked into this.  The only thing that looks at all 
tricky is posix.sgml, which might have to be artificially converted to a 
posix-api.h file just to fit within the Doxygen world.

All of this affects how cygwin-api.pdf and the HTML equivalents get 
built.  My changes so far don't affect these at all.

I assume you've come across Doxygen before in your travels.  I find its 
output far more useful for API references than DocBook.  And, Doxygen is 
in Cygwin, under someone else's maintenance now.
