Return-Path: <cygwin-patches-return-2954-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7706 invoked by alias); 11 Sep 2002 20:56:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7691 invoked from network); 11 Sep 2002 20:56:25 -0000
Message-ID: <3D7FADF3.5010805@etr-usa.com>
Date: Wed, 11 Sep 2002 13:56:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@sourceware.cygnus.com>
Subject: /etc/hosts symlink
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00402.txt.bz2

A few days ago, someone posted to the main Cygwin list wanting an 
/etc/hosts file.  The right thing is for this to be a symlink to 
Windows' own hosts file, since the Winsock resolver uses that file, and 
Cygwin programs use Winsock.

Following is a Bourne shell script fragment which finds the native hosts 
file and makes a symlink to it if it can find it and if /etc/hosts 
doesn't already exist.

This fragment is meant to go into one of the postinstall scripts.  I'm 
not supplying a diff format patch because I don't have a strong opinion 
on which one it should go in.  I propose inetutils, though a case could 
be made for cygwin.  The question is, whether 'tis nobler to turn the 
cygwin package into a dumping ground for random postinstall things, or 
to require people to install inetutils in order to get the /etc/hosts 
symlink.

I suppose it could be a standalone script like mkpasswd, but I think 
it's better that this happen once and automatically.

2002-09-11  Warren Young <warren@etr-usa.com>

	* postinstall: Find Windows' native hosts file and make a
	symlink to it in Cygwin's /etc.


The fragment:

if [ -n "$SYSTEMROOT" ]
then
         ETCPATH1=`cygpath "$SYSTEMROOT"`
         ETCPATH="$ETCPATH1/system32/drivers/etc"
elif [ -n "$WINDIR" ]
then
         ETCPATH=`cygpath "$WINDIR"`
fi

if [ -d "$ETCPATH" -a ! -e /etc/hosts ]
then
         ln -s "$ETCPATH/hosts" /etc/hosts
fi
