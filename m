Return-Path: <cygwin-patches-return-2815-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12981 invoked by alias); 11 Aug 2002 00:27:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12912 invoked from network); 11 Aug 2002 00:27:09 -0000
Message-ID: <20020811002708.15793.qmail@web14508.mail.yahoo.com>
Date: Sat, 10 Aug 2002 17:27:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: [GCC3.2]: Merge conflict in i386.c?
To: dj@redhat.com, charlet@act-europe.fr, gcc-bugs@gcc.gnu.org,
  Yura Bidas <yuri_b@mail.com>, binutils <binutils@sources.redhat.com>,
  Sam Blackburn <sam_blackburn@pobox.com>, J Boddy <J.Boddy@massey.ac.nz>,
  Boris <fbp@stlport.org>, Cygwin <cygwin@cygwin.com>,
  Cygwin <cygwin@sources.redhat.com>, cygwin-apps <cygwin-apps@cygwin.com>,
  cygwin-patches <cygwin-patches@cygwin.com>,
  Christopher Faylor <cgf@redhat.com>, Wayne F Foggat <frogway@voyager.co.nz>,
  GCC <gcc@gcc.gnu.org>, GCC Patches <gcc-patches@gcc.gnu.org>,
  "Javier_González" <xaviergonz@hotmail.com>,
  Mumit Khan <khan@nanotech.wisc.edu>, Eric Kohl <ekohl@rz-online.de>,
  MasseyLibrary <libextm@massey.ac.nz>,
  Mingw <mingw-users@lists.sourceforge.net>,
  mingw-dvlpr <mingw-dvlpr@lists.sourceforge.net>,
  Paul Muir <paul.muir@agresearch.co.nz>,
  newlib list <newlib@sources.redhat.com>, Thomas Pfaff <tpfaff@gmx.net>,
  pthreads <pthreads-win32@sources.redhat.com>,
  Sandy Smith <sandy.smith@hawkesbaydhb.govt.nz>,
  Thomas Smith <thomas_smith10@hotmail.com>,
  Paul Sokolovsky <paul-ml@is.lg.ua>, Charles Wilson <cwilson@ece.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00263.txt.bz2

Diff of my local tree with cygwin-mingw branch shows missing fastcall and
ms-bitfield stuff in i386.c.

Index: gcc/gcc/config/i386/i386.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/config/i386/i386.c,v
retrieving revision 1.368.2.19.2.2
diff -u -p -r1.368.2.19.2.2 i386.c
--- gcc/gcc/config/i386/i386.c	7 Aug 2002 18:10:57 -0000	1.368.2.19.2.2
+++ gcc/gcc/config/i386/i386.c	10 Aug 2002 09:09:31 -0000
@@ -724,6 +724,7 @@ static int ix86_comp_type_attributes PAR
 const struct attribute_spec ix86_attribute_table[];
 static tree ix86_handle_cdecl_attribute PARAMS ((tree *, tree, tree, int, bool
*));
 static tree ix86_handle_regparm_attribute PARAMS ((tree *, tree, tree, int,
bool *));
+static bool ix86_ms_bitfield_layout_p PARAMS ((tree));
 
 #ifdef DO_GLOBAL_CTORS_BODY
 static void ix86_svr3_asm_out_constructor PARAMS ((rtx, int));
@@ -820,6 +821,9 @@ static enum x86_64_reg_class merge_class
 #undef TARGET_SCHED_REORDER
 #define TARGET_SCHED_REORDER ix86_sched_reorder
 
+#undef TARGET_MS_BITFIELD_LAYOUT_P
+#define TARGET_MS_BITFIELD_LAYOUT_P ix86_ms_bitfield_layout_p
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 /* Sometimes certain combinations of command options do not make
@@ -1229,6 +1233,9 @@ const struct attribute_spec ix86_attribu
   /* Stdcall attribute says callee is responsible for popping arguments
      if they are not variable.  */
   { "stdcall",   0, 0, false, true,  true,  ix86_handle_cdecl_attribute },
+  /* Fastcall attribute says callee is responsible for popping arguments
+     if they are not variable.  */
+  { "fastcall",  0, 0, false, true,  true,  ix86_handle_cdecl_attribute },
   /* Cdecl attribute says the callee is a normal C declaration */
   { "cdecl",     0, 0, false, true,  true,  ix86_handle_cdecl_attribute },
   /* Regparm attribute specifies how many integer arguments are to be
@@ -1426,6 +1433,11 @@ ix86_comp_type_attributes (type1, type2)
   if (TREE_CODE (type1) != FUNCTION_TYPE)
     return 1;
 
+  /*  Check for mismatched fastcall types */ 
+  if (!lookup_attribute ("fastcall", TYPE_ATTRIBUTES (type1))
+      != !lookup_attribute ("fastcall", TYPE_ATTRIBUTES (type2)))
+    return 0; 
+
   /* Check for mismatched return types (cdecl vs stdcall).  */
   if (!lookup_attribute (rtdstr, TYPE_ATTRIBUTES (type1))
       != !lookup_attribute (rtdstr, TYPE_ATTRIBUTES (type2)))
@@ -1461,8 +1473,9 @@ ix86_return_pops_args (fundecl, funtype,
     /* Cdecl functions override -mrtd, and never pop the stack.  */
   if (! lookup_attribute ("cdecl", TYPE_ATTRIBUTES (funtype))) {
 
-    /* Stdcall functions will pop the stack if not variable args.  */
-    if (lookup_attribute ("stdcall", TYPE_ATTRIBUTES (funtype)))
+    /* Stdcall and fastcall functions will pop the stack if not variable args.
*/
+    if (lookup_attribute ("stdcall", TYPE_ATTRIBUTES (funtype))
+        || lookup_attribute ("fastcall", TYPE_ATTRIBUTES (funtype)))
       rtd = 1;
 
     if (rtd
@@ -1556,6 +1569,16 @@ init_cumulative_args (cum, fntype, libna
     }
   cum->maybe_vaarg = false;
 
+  /* Use ecx and edx registers if function has fastcall attribute */
+  if (fntype && !TARGET_64BIT)
+    {
+      if (lookup_attribute ("fastcall", TYPE_ATTRIBUTES (fntype)))
+	{
+	  cum->nregs = 2;
+	  cum->fastcall = 1;
+	}
+    }
+
   /* Determine if this function has variable arguments.  This is
      indicated by the last argument being 'void_type_mode' if there
      are no variable arguments.  If there are variable arguments, then
@@ -1570,7 +1593,10 @@ init_cumulative_args (cum, fntype, libna
 	  if (next_param == 0 && TREE_VALUE (param) != void_type_node)
 	    {
 	      if (!TARGET_64BIT)
-		cum->nregs = 0;
+		{
+		  cum->nregs = 0;
+		  cum->fastcall = 0;
+		}
 	      cum->maybe_vaarg = true;
 	    }
 	}
@@ -2211,7 +2237,22 @@ function_arg (cum, mode, type, named)
       case HImode:
       case QImode:
 	if (words <= cum->nregs)
-	  ret = gen_rtx_REG (mode, cum->regno);
+ 	{
+ 	  int regno = cum->regno;
+
+ 	  /* Fastcall allocates the first two DWORD (SImode) or
+ 	     smaller arguments to ECX and EDX.  */
+ 	  if (cum->fastcall)
+ 	    {
+ 	      if (mode == BLKmode || mode == DImode)
+ 		break;
+ 
+ 	      /* ECX not EAX is the first allocated register.  */
+ 	      if (regno == 0)
+ 		regno = 2;
+ 	    }
+ 	  ret = gen_rtx_REG (mode, regno);
+ 	}
 	break;
       case TImode:
 	if (cum->sse_nregs)
@@ -12557,6 +12598,17 @@ x86_order_regs_for_local_alloc ()
       at all.  */
    while (pos < FIRST_PSEUDO_REGISTER)
      reg_alloc_order [pos++] = 0;
+}
+
+#ifndef TARGET_USE_MS_BITFIELD_LAYOUT
+#define TARGET_USE_MS_BITFIELD_LAYOUT 0
+#endif
+
+static bool
+ix86_ms_bitfield_layout_p (record_type)
+     tree record_type ATTRIBUTE_UNUSED;
+{
+  return TARGET_USE_MS_BITFIELD_LAYOUT;
 }
 
 void


http://digital.yahoo.com.au - Yahoo! Digital How To
- Get the best out of your PC!
