Return-Path: <cygwin-patches-return-3740-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25557 invoked by alias); 23 Mar 2003 00:28:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25548 invoked from network); 23 Mar 2003 00:28:51 -0000
Date: Sun, 23 Mar 2003 00:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patched doc/setup-net.sgml
Message-ID: <20030323002907.GA12737@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030322201132.GA216@world-gov> <1048379098.912.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048379098.912.47.camel@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00389.txt.bz2

On Sun, Mar 23, 2003 at 11:24:59AM +1100, Robert Collins wrote:
>On Sun, 2003-03-23 at 07:11, Joshua Daniel Franklin wrote:
>> I just committed a big pactch to doc/setup-net.sgml that more or less
>> documents setup.exe. Resulting HTML can temporarily be seen at:
>> 
>> <http://iocc.com/~joshua/cygwin/setup-net.html>
>> 
>> 2003-03-22  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>> 
>>         * setup-net.sgml: Document setup.exe
>> 
>
>A few comments ( hope I'm not duplicating feedback here):
>* The cache should not be the same folder as the Cygwin root.
>
>Can you make this "must not be". setup *will* choke :[.
>
>* For most users, the Direct Connection method of downloading is the
>best choice.
>
>IMO the IE5 method is best. I've been considering making it the default.
>The IE5 method will leverage your IE5 cache and or organisational proxy
>server for performance. It will also honour browser auto-configuration
>scripts.
>
>* setup.ini
>setup actually downloads setup.bz2 these days, setup.ini is a suported 
>legacy config file. I don't know if you want to mention that or not.
>
>* along with some basic information about each package (version number,
>dependencies, checksum, etc.)
>You might want to skip this bit, and / or link to
>http://sources.redhat.com/cygwin-apps/setup.html#setup.ini
>i.e.: "From each selected mirror site, setup.exe downloads a small text
>file called setup.bz2 that contains a list of packages available from
>that mirror. For details on the format see the setup.exe <home page>".
>
>* packages are divided into categories
>you might want to say 'grouped into', or 'categorized by'. divided into
>could suggest literal division of individual packages to a non english
>reader - i.e. /bin files go into the foo package :].
>
>* a very basic Cygwin
>to me, 'minimal' reads more clearly than 'very basic'. Just a thought.
>
>* If you are interested in what is being done, the scripts are kept in
>the /etc/postinstall/ directory, renamed with a done extension after
>being run.
>
>I'd rather not have this in the users guide. It's one more place to
>update when things change... A reference to the setup package creation
>guide (http://cygwin.com/setup.html#postinstall) should suffice.
>
>Fantastic job otherwise!

Megadittos.  Great job.

I agree with all of Robert's observations, too, fwiw.

cgf
