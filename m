Return-Path: <cygwin-patches-return-3194-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15916 invoked by alias); 15 Nov 2002 19:43:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15904 invoked from network); 15 Nov 2002 19:43:21 -0000
Message-ID: <3DD54E46.9020605@netscape.net>
Date: Fri, 15 Nov 2002 11:43:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Okhapkin <sos@prospect.com.ru>
CC: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: select on serial fix
References: <041a01c28cd7$7ffbf070$0201a8c0@sos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00145.txt.bz2

Sergey Okhapkin wrote:
> The patch fixes a problem with a characters loss on select on a serial port.
> I wonder what PurgeComm() calls in the original code supposed to do...
> 
> 

If you're feeling motivated, mkfifo() still needs 
implimenting ;-).

Cheers,
Nicholas



