Return-Path: <cygwin-patches-return-3519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18110 invoked by alias); 6 Feb 2003 02:54:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18101 invoked from network); 6 Feb 2003 02:54:32 -0000
Date: Thu, 06 Feb 2003 02:54:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: heap_chunk_in_mb patch
Message-ID: <20030206025522.GA3732@world-gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00168.txt.bz2


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 238

I committed this patch to document heap_chunk_in_mb.

2003-02-05  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* setup-net.sgml: Add "setup-maxmem" section 
	* setup2.sgml: New section "setup-maxmem" to document heap_chunk_in_mb


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tmp.patch"
Content-length: 3145

Index: setup-net.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/setup-net.sgml,v
retrieving revision 1.4
diff -u -p -r1.4 setup-net.sgml
--- setup-net.sgml	4 Dec 2001 04:20:31 -0000	1.4
+++ setup-net.sgml	6 Feb 2003 02:49:33 -0000
@@ -10,6 +10,7 @@ Follow the instructions on each screen t
 </sect1>
 
 DOCTOOL-INSERT-setup-env
+DOCTOOL-INSERT-setup-maxmem
 DOCTOOL-INSERT-ntsec
 DOCTOOL-INSERT-setup-files
 </chapter>
Index: setup2.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/setup2.sgml,v
retrieving revision 1.5
diff -u -p -r1.5 setup2.sgml
--- setup2.sgml	4 Dec 2001 04:20:31 -0000	1.5
+++ setup2.sgml	6 Feb 2003 02:49:33 -0000
@@ -55,6 +55,74 @@ first starts.  Most Cygwin applications 
 
 </sect1>
 
+<sect1 id="setup-maxmem"><title>Changing Cygwin's Maximum Memory</title>
+
+<para>
+By default no Cygwin program can allocate more than 384 MB of memory 
+(program+data).  You should not need to change this default in most 
+circumstances.  However, if you need to use more real or virtual memory in 
+your machine you may add an entry in the either the 
+<literal>HKEY_LOCAL_MACHINE</literal> (to change the limit for all users) or 
+<literal>HKEY_CURRENT_USER</literal> (for just the current user) section of 
+the registry. 
+</para>
+
+<para>
+Add the <literal>DWORD</literal> value <literal>heap_chunk_in_mb</literal> 
+and set it to the desired memory limit in decimal MB. It is preferred to do 
+this in Cygwin using the <command>regtool</command> program included in the 
+Cygwin package.
+(For more information about <command>regtool</command> or the other Cygwin 
+utilities, see <Xref Linkend="using-utils"> or use each the
+<literal>--help</literal> option of each util.)  You should always be careful 
+when using <command>regtool</command> since damaging your system registry can 
+result in an unusable system.  This example sets memory limit to 1024 MB:
+
+<screen>
+regtool -i set /HKLM/Software/Cygnus\ Solutions/Cygwin/heap_chunk_in_mb 1024
+regtool -v list /HKLM/Software/Cygnus\ Solutions/Cygwin
+</screen>
+</para>
+
+<para>
+Exit all running Cygwin processes and restart them. Memory can be allocated up 
+to the size of the system swap space minus any the size of any running 
+processes. The system swap should be at least as large as the physically 
+installed RAM and can be modified under the System category of the 
+Control Panel.  
+</para>
+
+<para>
+Here is a small program written by DJ Delorie that tests the 
+memory allocation limit on your system:
+
+<screen>
+main()
+{
+  unsigned int bit=0x40000000, sum=0;
+  char *x;
+  
+  while (bit > 4096) 
+  {
+    x = malloc(bit);
+    if (x)
+    sum += bit;
+    bit >>= 1;
+  }
+  printf("%08x bytes (%.1fMb)\n", sum, sum/1024.0/1024.0);
+  return 0;
+}
+</screen>
+
+You can compile this program using:
+<screen>
+gcc max_memory.c -o max_memory.exe
+</screen>
+
+Run the program and it will output the maximum amount of allocatable memory.
+</para>
+</sect1>
+
 <sect1 id="setup-files"><title>Customizing bash</title>
 
 <para>

--AqsLC8rIMeq19msA--
