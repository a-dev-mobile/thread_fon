// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:threadfon/config/styles/app_text_style.dart';
import 'package:threadfon/core/constants/common.dart';
import 'package:threadfon/modules/threads/view/m_thread/cubit/m_thread_cubit.dart';
import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_diam/view/m_thread_diam_page.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class MThreadMaleFemalePage extends StatelessWidget {
  const MThreadMaleFemalePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            Localization.of(context).thread_type,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChoiceTypeThread(
                onTap: () {
                  context.read<MThreadCubit>().setMale(false);
                  nextScreen(context);
                },
                pathSvg: ConstAssets.svgNuts,
                text: Localization.of(context).internal_thread,
              ),
            ),
            Expanded(
              child: ChoiceTypeThread(
                onTap: () {
                  context.read<MThreadCubit>().setMale(true);
                  nextScreen(context);
                },
                pathSvg: ConstAssets.svgBolt,
                text: Localization.of(context).external_thread,
              ),
            ),
            SizedBox(
              height: 180.h,
            ),
          ],
        ),
      );

  void nextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MThreadDiamPage(),
      ),
    );
  }
}

class ChoiceTypeThread extends StatelessWidget {
  const ChoiceTypeThread({
    required this.pathSvg,
    required this.text,
    required this.onTap,
    super.key,
  });

  final String pathSvg;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    // final colorText = Theme.of(context).textTheme.bodyText1!.color;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      margin: EdgeInsets.all(8.h),
      color: scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0.h),
                child: SvgPicture.asset(
                  pathSvg,
                  // color: colorText,
                  // height: 120.h,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyle.LABEL_SEMI_BOLD(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* package a.dev.mobile_threadpro.mThread;




public class MetrFragment extends Fragment implements AdapterView.OnItemClickListener {
    public static final int ISO_DIAMETER_ID = 1;
    public static final int ISO_PITCH_ID = 2;
    public static final int ISO_TOLERANCE_ID = 3;
    public static final int ISO_INFO_ID = 4;
    public static final double COARSE_PITCH = 9999;
    public static final double FINE_PITCH = 8888;
    public static final double SUPER_FINE_PITCH = 7777;
    private static final String ARG_CURRENT_FRAG_NUMBER = "selectedFrag";
    public static int idIsoItemFrag = ISO_DIAMETER_ID;
    /**
     * ********utils*************
     */
    static String middleDiam;
    static String weightThread;
    static String miniorNuts;
    static double basicMiniordBolt;
    /*master variables*/
    private static double nomDiam;
    private static double pitch;
    private static boolean isExternal = false;
    private static int _id = 0;
    private static boolean isVisible = false;
    private static boolean isInch = false;
    private static boolean isBigPitch;
    private static String tolerance;
    ListView listView;
    LinearLayout linearLayout;
    private MetrAdapter metrAdapter;
    private FragmentActivity activity;
    private ArrayList<String> arrayList;
    private OnIdFragSelectedListenerFromISO callbackFromISO;
    private List<MetrItem> metrItems;
    private Menu menuThread;

    private static String formatDecimal(double number) {
        DecimalFormat myFormatter = new DecimalFormat("###.###");
        return myFormatter.format(number).replaceAll(",", "\\.");
    }

    public MetrFragment newInstance(int idItemFrag) {
        MetrFragment mFragment = new MetrFragment();
        Bundle mBundle = new Bundle();
        mBundle.putInt(ARG_CURRENT_FRAG_NUMBER, idItemFrag);
        mFragment.setArguments(mBundle);
        return mFragment;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        this.activity = (FragmentActivity) activity;
        // This makes sure that the container activity has implemented
        // the callback interface. If not, it throws an exception.
        try {
            callbackFromISO = (OnIdFragSelectedListenerFromISO) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnHeadlineSelectedListener");
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        Bundle args = getArguments();
        if (args != null) {
            idIsoItemFrag = args.getInt(ARG_CURRENT_FRAG_NUMBER);
        }
        if (savedInstanceState != null) {
            onRestoreInstanceState(savedInstanceState);
        }


        View view = null;

        if (idIsoItemFrag == ISO_DIAMETER_ID || idIsoItemFrag == ISO_TOLERANCE_ID || idIsoItemFrag == ISO_PITCH_ID) {
            view = inflater.inflate(R.layout.lv_fragment, container, false);
            listView = (ListView) view.findViewById(R.id.lv_fragment);
            listView.setOnItemClickListener(this);


        } else {

            if (isExternal) {
                view = inflater.inflate(R.layout.info_metr_ex, container, false);

            } else {
                view = inflater.inflate(R.layout.info_metr_in, container, false);

            }
            linearLayout = (LinearLayout) view.findViewById(R.id.custom_view);
            if (isVisible) {
                linearLayout.setVisibility(View.VISIBLE);
            } else {
                linearLayout.setVisibility(View.GONE);

            }
        }


        switch (idIsoItemFrag) {
            case ISO_DIAMETER_ID:
                queryDiam();
                break;
            case ISO_PITCH_ID:
                queryPitch();
                break;

            case ISO_TOLERANCE_ID:
                queryTolerance();
                break;
            case ISO_INFO_ID:
                queryInfo();
                if (isExternal) {
                    findViewForExternalThread(view);
                } else {
                    findViewForInternalThread(view);

                }


                break;


        }

        return view;
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {


        switch (idIsoItemFrag) {
            case ISO_DIAMETER_ID:
                saveIntInFile(listView.getFirstVisiblePosition());
                nomDiam = metrItems.get(position).getNomDiam();
                callbackFromISO.callbackFromISO(ISO_PITCH_ID);
                break;
            case ISO_PITCH_ID:
                pitch = metrItems.get(position).getPitch();

                if (nomDiam < 1) {
                    Toast.makeText(activity, activity.getString(R.string.no_data), Toast.LENGTH_SHORT).show();
                } else {
                    callbackFromISO.callbackFromISO(ISO_TOLERANCE_ID);

                }


                break;
            case ISO_TOLERANCE_ID:
                tolerance = metrItems.get(position).getTolerance();
                callbackFromISO.callbackFromISO(ISO_INFO_ID);
                break;
        }


    }

    //Here you can restore saved data in onSaveInstanceState Bundle
    private void onRestoreInstanceState(Bundle savedInstanceState) {
        if (savedInstanceState != null) {
            idIsoItemFrag = savedInstanceState.getInt("idItemFragIso");
            pitch = savedInstanceState.getDouble("pitch");
            nomDiam = savedInstanceState.getDouble("nomDiam");
            isExternal = savedInstanceState.getBoolean("isExternal");
            isVisible = savedInstanceState.getBoolean("isVisible");
            isInch = savedInstanceState.getBoolean("isInch");
            tolerance = savedInstanceState.getString("tolerance");
        }
    }

    //Here you Save your data
    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putInt("idItemFragIso", idIsoItemFrag);
        outState.putDouble("nomDiam", nomDiam);
        outState.putDouble("pitch", pitch);
        outState.putBoolean("isExternal", isExternal);
        outState.putBoolean("isVisible", isVisible);
        outState.putBoolean("isInch", isInch);
        outState.putString("tolerance", tolerance);

    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setRetainInstance(true);
    }

    /**
     * *******************START QUERY*****************
     */

    private void queryPitch() {
        String query;
        Cursor cursor;

        ExternalDbOpenHelper dbOpenHelper = new ExternalDbOpenHelper(activity);
        SQLiteDatabase database = dbOpenHelper.openDataBase();
        double[] pitchs;
        query = "select * from [isoNormal]n " +
                "where n.[Range_1] = " + nomDiam +
                " or n.[Range_2] = " + nomDiam +
                " or n.[Range_3] = " + nomDiam;
        cursor = database.rawQuery(query, null);

        ArrayList<Double> doubleArrayList = requestHandlerPitchCoarseAndFine(cursor, true);

        query = "select *  from  [isoSmail]s" +
                " where s.[Range_1] = " + nomDiam +
                " or s.[Range_2] = " + nomDiam;


        cursor = database.rawQuery(query, null);
        doubleArrayList.addAll(requestHandlerPitchCoarseAndFine(cursor, false));

        cursor.close();
        database.close();
        dbOpenHelper.close();

        pitchs = UtilsArray.toPrimitive(doubleArrayList);

        metrItems = new ArrayList<MetrItem>();
        for (double pitch : pitchs) {
            MetrItem metrItem;
            if (pitch == COARSE_PITCH || pitch == FINE_PITCH || pitch == SUPER_FINE_PITCH) {
                metrItem = new MetrItem(nomDiam, pitch, true);
                metrItems.add(metrItem);
            } else {
                metrItem = new MetrItem(nomDiam, pitch);
                metrItems.add(metrItem);
            }
        }
        metrAdapter = new MetrAdapter(activity, idIsoItemFrag, metrItems);

        listView.setAdapter(metrAdapter);
    }

    public ArrayList<Double> requestHandlerPitchCoarseAndFine(Cursor cursor, boolean isFirstQuery) {
        ArrayList<Double> arrayList = new ArrayList<Double>();
        boolean isFirstcall = true;
        if (isFirstQuery) {
            String nameColumnPitchCoarse = "StandardPitch";
            if (cursor.moveToFirst()) {
                do {
                    for (int i = 4; i < cursor.getColumnCount(); i++) {
                        //добавляем имя столбца
                        if (cursor.getColumnName(i).equals(nameColumnPitchCoarse)) {
                            if (cursor.getDouble(i) != 0) {
                                arrayList.add(MetrFragment.COARSE_PITCH);
                                arrayList.add(cursor.getDouble(i));
                            }
                        } else {
                            if (cursor.getDouble(i) != 0) {
                                if (isFirstcall) {
                                    arrayList.add(MetrFragment.FINE_PITCH);
                                    isFirstcall = false;
                                }
                                arrayList.add(cursor.getDouble(i));
                            }
                        }
                    }


                } while (cursor.moveToNext());
            }
        } else {
            if (cursor.moveToFirst()) {
                do {
                    for (int i = 3; i < cursor.getColumnCount(); i++) {
                        if (cursor.getDouble(i) != 0) {
                            if (isFirstcall) {
                                arrayList.add(MetrFragment.SUPER_FINE_PITCH);
                                isFirstcall = false;
                            }
                            arrayList.add(cursor.getDouble(i));
                        }
                    }
                } while (cursor.moveToNext());
            }
        }
        return arrayList;
    }

    private void queryDiam() {
        String query;
        Cursor cursor;
        ExternalDbOpenHelper dbOpenHelper = new ExternalDbOpenHelper(activity);
        SQLiteDatabase database = dbOpenHelper.openDataBase();
        double[] nominalDiameters;
        query = "select n.[Range_1] as nomDiam  from  [isoNormal]n " +
                "UNION " +
                "select n.[Range_2]  from [isoNormal]n " +
                "UNION " +
                "select n.[Range_3]  from  [isoNormal]n " +
                "UNION " +
                "select s.[Range_1]  from [isoSmail]s " +
                "UNION " +
                "select s.[Range_2]  from  [isoSmail]s ";

        cursor = database.rawQuery(query, null);


        nominalDiameters = UtilsArray.arrayDoubleFromCursor(cursor, "nomDiam");
        cursor.close();
        database.close();
        dbOpenHelper.close();
        metrItems = new ArrayList<MetrItem>();
        for (double nominalDiameter : nominalDiameters) {
            MetrItem metrItem;
            metrItem = new MetrItem(nominalDiameter);
            metrItems.add(metrItem);
        }
        metrAdapter = new MetrAdapter(activity, idIsoItemFrag, metrItems);
        listView.setAdapter(metrAdapter);
        listView.setSelection(loadIntFromFile());

    }

    private void queryTolerance() {
        String query;
        Cursor cursor;


        ExternalDbOpenHelper dbOpenHelper = new ExternalDbOpenHelper(activity);
        SQLiteDatabase database = dbOpenHelper.openDataBase();

        String[] partTolerance;

        query = "select * from [IsoTolerance]t" +
                " where t.[Pitch] = " + pitch +
                " and  t.[Diameter]  = " + typeDiam();
        cursor = database.rawQuery(query, null);

        arrayList = new ArrayList<String>();


        if (cursor.moveToFirst()) {
            _id = cursor.getInt(0);

            for (int i = 3; i < cursor.getColumnCount(); i++) {

                if (cursor.getString(i) != null) {
                    partTolerance = cursor.getColumnName(i).split("_");
                    if (isExternal) {
                        if (partTolerance.length > 2 & partTolerance.length <= 3) {
                            arrayList.add(partTolerance[2]);
                        }
                    } else {
                        if (partTolerance.length > 3) {
                            arrayList.add(partTolerance[2]);
                        }
                    }
                }
            }
        }

        arrayList = new ArrayList<String>(new HashSet<String>(arrayList));
        Collections.sort(arrayList);

        partTolerance = arrayList.toArray(new String[arrayList.size()]);

        cursor.close();
        database.close();
        dbOpenHelper.close();
        metrItems = new ArrayList<MetrItem>();
        for (String tolerance : partTolerance) {
            MetrItem metrItem;
            metrItem = new MetrItem(_id, nomDiam, pitch, tolerance);
            metrItems.add(metrItem);
        }
        metrAdapter = new MetrAdapter(activity, idIsoItemFrag, metrItems);
        listView.setAdapter(metrAdapter);

    }

    private void queryInfo() {
        double es_d;
        double ei_d;
        double es_d1;
        double ei_d1;
        double es_d2;
        double ei_d2;
        es_d = ei_d = es_d1 = ei_d1 = es_d2 = ei_d2 = 0;
        String getEsOrEi;


        String query;
        Cursor cursor;
        ExternalDbOpenHelper dbOpenHelper = new ExternalDbOpenHelper(activity);
        SQLiteDatabase database = dbOpenHelper.openDataBase();
        query = "select * from IsoTolerance where _id = " + _id;
        cursor = database.rawQuery(query, null);
        String[] partTolerance;
        if (cursor.moveToFirst()) {
            for (int i = 3; i < cursor.getColumnCount(); i++) {
                if (cursor.getString(i) != null) {
                    partTolerance = cursor.getColumnName(i).split("_");

                    if (partTolerance[2].equals(tolerance)) {
                        getEsOrEi = partTolerance[0] + "_" + partTolerance[1];

                        if (isExternal) {
                            if (partTolerance.length > 1 & partTolerance.length <= 3) {
                                if (getEsOrEi.equals("ei_d")) {
                                    ei_d = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("es_d")) {
                                    es_d = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("es_d1")) {
                                    es_d1 = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("ei_d1")) {
                                    ei_d1 = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("ei_d2")) {
                                    ei_d2 = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("es_d2")) {
                                    es_d2 = cursor.getDouble(i) / 1000;
                                }
                            }
                        } else {
                            if (partTolerance.length > 3) {
                                if (getEsOrEi.equals("ei_d")) {
                                    ei_d = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("es_d")) {
                                    es_d = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("es_d1")) {
                                    es_d1 = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("ei_d1")) {
                                    ei_d1 = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("ei_d2")) {
                                    ei_d2 = cursor.getDouble(i) / 1000;
                                } else if (getEsOrEi.equals("es_d2")) {
                                    es_d2 = cursor.getDouble(i) / 1000;
                                }
                            }

                        }
                    }
                }
            }
        }

        arrayList = new ArrayList<String>();
        cursor.close();
        database.close();
        dbOpenHelper.close();

        String sDiam = formatDecimal(nomDiam);
        String sPitch = formatDecimal(pitch);


        isBigPitch();
        arrayList.add("");
        // 1 add thread designations
        if (isBigPitch) {
            arrayList.add("M" + sDiam + "-" + tolerance);
        } else {
            arrayList.add("M" + sDiam + "x" + sPitch + "-" + tolerance);
        }
        // 2 add nom diam
        arrayList.add(sDiam);
        //3 add thread pitch
        if (isBigPitch) {
            arrayList.add("(" + activity.getResources().getString(R.string.coarse_pitch) + ") " + sPitch);
        } else {
            arrayList.add("(" + activity.getResources().getString(R.string.fine_pitch) + ") " + sPitch);
        }
        // 4 add tolerance
        arrayList.add(tolerance);
        //5 add Thread depth
        if (isExternal) {
            weightThread = formatDecimal((nomDiam - basicMiniordBolt()) / 2);
            arrayList.add(formatDecimal((nomDiam - basicMiniordBolt()) / 2));
        } else {
            weightThread = (formatDecimal((nomDiam - basicMiniorNuts()) / 2));
            arrayList.add(formatDecimal((nomDiam - basicMiniorNuts()) / 2));
        }
        // 6 add minor or major diameter
        if (isExternal) {
            arrayList.add(sDiam);
        } else {
            arrayList.add(formatDecimal(basicMiniorNuts()));
            miniorNuts = formatDecimal(basicMiniorNuts());
        }

        //(7) 6_1 add tolerance diameter
        if (isExternal) {
            arrayList.add(formatDecimal(es_d));
        } else {
            arrayList.add(formatDecimal(es_d1));
        }
        //(8)6_2
        if (isExternal) {
            arrayList.add(formatDecimal(ei_d));
        } else {
            arrayList.add(formatDecimal(ei_d1));
        }
        //9 add min
        if (isExternal) {
            arrayList.add(formatDecimal(nomDiam + ei_d));
        } else {
            arrayList.add(formatDecimal(basicMiniorNuts() + ei_d1));
        }
        //10 add mean
        if (isExternal) {
            arrayList.add(formatDecimal(((nomDiam + ei_d) + (nomDiam + es_d)) / 2));
        } else {
            arrayList.add(formatDecimal(((basicMiniorNuts() + ei_d1) + (basicMiniorNuts() + es_d1)) / 2));
        }
        //11 add max

        if (isExternal) {
            arrayList.add(formatDecimal(nomDiam + es_d));
        } else {
            arrayList.add(formatDecimal(basicMiniorNuts() + es_d1));

        }
        // (12)10 add middle
        arrayList.add(formatDecimal(midllePitchD2d2()));
        middleDiam = formatDecimal(midllePitchD2d2());
        // (13) 10_1
        arrayList.add(formatDecimal(es_d2));
        // (14) 10_2
        arrayList.add(formatDecimal(ei_d2));
        //(15) add min
        arrayList.add(formatDecimal((midllePitchD2d2() + ei_d2)));
        //(16) add mean
        arrayList.add(formatDecimal(((midllePitchD2d2() + ei_d2) + ((midllePitchD2d2() + es_d2))) / 2));

        //(17) add max
        arrayList.add(formatDecimal((midllePitchD2d2() + es_d2)));


    }

    /**
     * *******************END QUERY*****************
     */


    private void findViewForInternalThread(View view) {
        TextView tv_1 = (TextView) view.findViewById(R.id.tv_1);
        TextView tv_2 = (TextView) view.findViewById(R.id.tv_2);
        TextView tv_3 = (TextView) view.findViewById(R.id.tv_3);
        TextView tv_4 = (TextView) view.findViewById(R.id.tv_4);
        TextView tv_5 = (TextView) view.findViewById(R.id.tv_5);
        TextView tv_6 = (TextView) view.findViewById(R.id.tv_6);
        TextView tv_6_1 = (TextView) view.findViewById(R.id.tv_7);
        TextView tv_6_2 = (TextView) view.findViewById(R.id.tv_8);
        TextView tv_7 = (TextView) view.findViewById(R.id.tv_9);
        TextView tv_8 = (TextView) view.findViewById(R.id.tv_10);
        TextView tv_9 = (TextView) view.findViewById(R.id.tv_11);
        TextView tv_10 = (TextView) view.findViewById(R.id.tv_12);
        TextView tv_10_1 = (TextView) view.findViewById(R.id.tv_13);
        TextView tv_10_2 = (TextView) view.findViewById(R.id.tv_14);
        TextView tv_11 = (TextView) view.findViewById(R.id.tv_15);
        TextView tv_12 = (TextView) view.findViewById(R.id.tv_16);
        TextView tv_13 = (TextView) view.findViewById(R.id.tv_17);

        tv_1.setText(arrayList.get(1));
        tv_2.setText(arrayList.get(2));
        tv_3.setText(arrayList.get(3));
        tv_4.setText(arrayList.get(4));


        if (isInch) {
            tv_5.setText(UtilsConvert.mmToInch(arrayList.get(5)));
            tv_6.setText(UtilsConvert.mmToInch(arrayList.get(6)));
            tv_6_1.setText(UtilsConvert.mmToInch(arrayList.get(7)));
            tv_6_2.setText(UtilsConvert.mmToInch(arrayList.get(8)));
            tv_7.setText(UtilsConvert.mmToInch(arrayList.get(9)));
            tv_8.setText(UtilsConvert.mmToInch(arrayList.get(10)));
            tv_9.setText(UtilsConvert.mmToInch(arrayList.get(11)));
            tv_10.setText(UtilsConvert.mmToInch(arrayList.get(12)));
            tv_10_1.setText(UtilsConvert.mmToInch(arrayList.get(13)));
            tv_10_2.setText(UtilsConvert.mmToInch(arrayList.get(14)));
            tv_11.setText(UtilsConvert.mmToInch(arrayList.get(15)));
            tv_12.setText(UtilsConvert.mmToInch(arrayList.get(16)));
            tv_13.setText(UtilsConvert.mmToInch(arrayList.get(17)));
        } else {
            tv_5.setText(arrayList.get(5));
            tv_6.setText(arrayList.get(6));
            tv_6_1.setText(arrayList.get(7));
            tv_6_2.setText(arrayList.get(8));
            tv_7.setText(arrayList.get(9));
            tv_8.setText(arrayList.get(10));
            tv_9.setText(arrayList.get(11));
            tv_10.setText(arrayList.get(12));
            tv_10_1.setText(arrayList.get(13));
            tv_10_2.setText(arrayList.get(14));
            tv_11.setText(arrayList.get(15));
            tv_12.setText(arrayList.get(16));
            tv_13.setText(arrayList.get(17));
        }


    }

    private void findViewForExternalThread(View view) {
        TextView tv_1 = (TextView) view.findViewById(R.id.tv_1);
        TextView tv_2 = (TextView) view.findViewById(R.id.tv_2);
        TextView tv_3 = (TextView) view.findViewById(R.id.tv_3);
        TextView tv_4 = (TextView) view.findViewById(R.id.tv_4);
        TextView tv_5 = (TextView) view.findViewById(R.id.tv_5);
        TextView tv_6 = (TextView) view.findViewById(R.id.tv_6);
        TextView tv_6_1 = (TextView) view.findViewById(R.id.tv_7);
        TextView tv_6_2 = (TextView) view.findViewById(R.id.tv_8);
        TextView tv_7 = (TextView) view.findViewById(R.id.tv_9);
        TextView tv_8 = (TextView) view.findViewById(R.id.tv_10);
        TextView tv_9 = (TextView) view.findViewById(R.id.tv_11);
        TextView tv_10 = (TextView) view.findViewById(R.id.tv_12);
        TextView tv_10_1 = (TextView) view.findViewById(R.id.tv_13);
        TextView tv_10_2 = (TextView) view.findViewById(R.id.tv_14);
        TextView tv_11 = (TextView) view.findViewById(R.id.tv_15);
        TextView tv_12 = (TextView) view.findViewById(R.id.tv_16);
        TextView tv_13 = (TextView) view.findViewById(R.id.tv_17);

        tv_1.setText(arrayList.get(1));
        tv_2.setText(arrayList.get(2));
        tv_3.setText(arrayList.get(3));
        tv_4.setText(arrayList.get(4));

        if (isInch) {
            tv_5.setText(UtilsConvert.mmToInch(arrayList.get(5)));
            tv_6.setText(UtilsConvert.mmToInch(arrayList.get(6)));
            tv_6_1.setText(UtilsConvert.mmToInch(arrayList.get(7)));
            tv_6_2.setText(UtilsConvert.mmToInch(arrayList.get(8)));
            tv_7.setText(UtilsConvert.mmToInch(arrayList.get(9)));
            tv_8.setText(UtilsConvert.mmToInch(arrayList.get(10)));
            tv_9.setText(UtilsConvert.mmToInch(arrayList.get(11)));
            tv_10.setText(UtilsConvert.mmToInch(arrayList.get(12)));
            tv_10_1.setText(UtilsConvert.mmToInch(arrayList.get(13)));
            tv_10_2.setText(UtilsConvert.mmToInch(arrayList.get(14)));
            tv_11.setText(UtilsConvert.mmToInch(arrayList.get(15)));
            tv_12.setText(UtilsConvert.mmToInch(arrayList.get(16)));
            tv_13.setText(UtilsConvert.mmToInch(arrayList.get(17)));
        } else {
            tv_5.setText(arrayList.get(5));
            tv_6.setText(arrayList.get(6));
            tv_6_1.setText(arrayList.get(7));
            tv_6_2.setText(arrayList.get(8));
            tv_7.setText(arrayList.get(9));
            tv_8.setText(arrayList.get(10));
            tv_9.setText(arrayList.get(11));
            tv_10.setText(arrayList.get(12));
            tv_10_1.setText(arrayList.get(13));
            tv_10_2.setText(arrayList.get(14));
            tv_11.setText(arrayList.get(15));
            tv_12.setText(arrayList.get(16));
            tv_13.setText(arrayList.get(17));
        }
    }

    private double basicMiniordBolt() {
        basicMiniordBolt = (nomDiam - 1.226869322 * pitch);
        return basicMiniordBolt;
    }


    private double basicMiniorNuts() {
        return (nomDiam - 1.082531755 * pitch);

    }

    private double midllePitchD2d2() {
        return (nomDiam - 0.649519053 * pitch);
    }

    /**
     * ****************************
     */


    private void isBigPitch() {
        ExternalDbOpenHelper dbOpenHelper = new ExternalDbOpenHelper(activity);
        SQLiteDatabase database = dbOpenHelper.openDataBase();

        Cursor cursor = database.rawQuery(
                " select n.[StandardPitch] from  [isoNormal]n " +
                        " where n.[StandardPitch] = " + pitch +
                        " and ( n.[Range_1] = " + nomDiam +
                        " or n.[Range_2] = " + nomDiam +
                        " or n.[Range_3] = " + nomDiam + " ) ", null);
        isBigPitch = false;
        if (cursor.moveToFirst()) {
            if (cursor.getString(0) != null) {
                isBigPitch = true;
            }

        }
        cursor.close();
        database.close();
        dbOpenHelper.close();


    }

    private int typeDiam() {
        if (nomDiam <= 1.4 & nomDiam >= 1) {
            return 1;
        } else if ((nomDiam) <= 2.8 & (nomDiam) >= 1.4) {
            return 2;
        } else if ((nomDiam) <= 5.6 & (nomDiam) >= 2.8) {
            return 3;
        } else if ((nomDiam) <= 11.2 & (nomDiam) >= 5.6) {
            return 4;
        } else if ((nomDiam) <= 22.4 & (nomDiam) >= 11.2) {
            return 5;
        } else if (nomDiam <= 45 & (nomDiam) >= 22.4) {
            return 6;
        } else if (nomDiam <= 90 & (nomDiam) >= 45) {
            return 7;
        } else if (nomDiam <= 180 & (nomDiam) >= 90) {
            return 8;
        } else if (nomDiam <= 355 & (nomDiam) >= 180) {
            return 9;
        } else if (nomDiam <= 600 & (nomDiam) >= 355) {
            return 10;
        }
        return 0;
    }

    private void saveIntInFile(int value) {
        SharedPreferences sharedPreferences;
        sharedPreferences = activity.getSharedPreferences(AppConst.SHARED_PREFERENCES, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putInt(AppConst.PREF_ISO_LAST_POS_LV, value);
        editor.apply();
    }


    private int loadIntFromFile() {
        SharedPreferences sharedPreferences;
        int i = 50;
        sharedPreferences = activity.getSharedPreferences(AppConst.SHARED_PREFERENCES, Context.MODE_PRIVATE);
        if (sharedPreferences.contains(AppConst.PREF_ISO_LAST_POS_LV)) {
            i = sharedPreferences.getInt(AppConst.PREF_ISO_LAST_POS_LV, i);
        }
        return i;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.iso_menu, menu);
        menuThread = menu;
        int i;
        switch (idIsoItemFrag) {
            case ISO_TOLERANCE_ID:
                menu.findItem(R.id.external_or_internal).setVisible(true);
                i = isExternal ? R.mipmap._bolt : R.mipmap._nuts;
                menu.findItem(R.id.external_or_internal).setIcon(i);
                break;
            case ISO_INFO_ID:
                menu.findItem(R.id.visible_or_invisible).setVisible(true);
                i = isVisible ? R.mipmap._visible : R.mipmap._invisible;
                menuThread.findItem(R.id.visible_or_invisible).setIcon(i);
                if (isVisible) {
                    if (linearLayout != null)
                        linearLayout.setVisibility(View.VISIBLE);
                } else {
                    if (linearLayout != null)
                        linearLayout.setVisibility(View.GONE);

                }
                String s;
                s = isInch ? activity.getString(R.string.inch) : activity.getString(R.string.mm);
                menu.findItem(R.id.inch_or_mm).setVisible(true).setTitle(s);
                break;


        }


    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int i;
        switch (item.getItemId()) {
            case R.id.external_or_internal:
                i = isExternal ? R.mipmap._nuts : R.mipmap._bolt;
                menuThread.findItem(R.id.external_or_internal).setIcon(i);
                isExternal = !isExternal;
                queryTolerance();
                metrAdapter.notifyDataSetChanged();
                break;

            case R.id.visible_or_invisible:
                i = isVisible ? R.mipmap._invisible : R.mipmap._visible;
                isVisible = !isVisible;
                menuThread.findItem(R.id.visible_or_invisible).setIcon(i);
                if (isVisible) {
                    if (linearLayout != null)
                        linearLayout.setVisibility(View.VISIBLE);
                } else {
                    if (linearLayout != null)
                        linearLayout.setVisibility(View.GONE);

                }


                break;
            case R.id.inch_or_mm:
                String s;
                s = !isInch ? activity.getString(R.string.inch) : activity.getString(R.string.mm);
                menuThread.findItem(R.id.inch_or_mm).setTitle(s);
                isInch = !isInch;
                callbackFromISO.callbackFromISO(ISO_INFO_ID);

                break;
        }

        return true;
    }


    public interface OnIdFragSelectedListenerFromISO {


        public void callbackFromISO(int idItemFrag);

    }

    public static class ThreadView extends View {
        Bitmap resizedBitmap;
        float dpi;
        float pointX;
        float pointY;
        float scaleImage;
        private Matrix matrix;
        private Paint paint;
        private Bitmap bitmapOriginal;


        public ThreadView(Context context, AttributeSet attrs) {
            super(context, attrs);
            if (!isInEditMode()) {
                init();
            }
        }


        public ThreadView(Context context, AttributeSet attrs, int defStyleAttr) {
            super(context, attrs, defStyleAttr);

            if (!isInEditMode()) {
                init();
            }
        }


        public ThreadView(Context context) {
            super(context);
            if (!isInEditMode()) {
                init();
            }
        }

        public void init() {
            dpi = getResources().getDisplayMetrics().density;
            paint = new Paint();
            matrix = new Matrix();

            if (isExternal) {
                bitmapOriginal = BitmapFactory.decodeResource(getResources(), R.drawable.bolt);
            } else {
                bitmapOriginal = BitmapFactory.decodeResource(getResources(), R.drawable.nuts);
            }


        }

        @Override
        protected void onDraw(Canvas canvas) {
            canvas.drawColor(getResources().getColor(R.color.background));
            resizedBitmapFullView(canvas, bitmapOriginal);
            String sDiam = formatDecimal(nomDiam);

            String sPitch = formatDecimal(pitch);

            if (isInch) {
                if (isExternal) {
                    drawText(canvas, UtilsConvert.mmToInch(weightThread), 25, Color.BLACK, 30, 74, 0, Paint.Align.LEFT);
                    drawText(canvas, UtilsConvert.mmToInch(sPitch), 25, Color.BLACK, 470, 337, 0, Paint.Align.CENTER);
                    drawText(canvas, "ø " + UtilsConvert.mmToInch(sDiam), 25, Color.BLACK, 966, 222, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + UtilsConvert.mmToInch(middleDiam), 25, Color.BLACK, 856, 275, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + UtilsConvert.mmToInch(formatDecimal(basicMiniordBolt)), 25, Color.BLACK, 736, 341, -90, Paint.Align.RIGHT);
                } else {
                    drawText(canvas, UtilsConvert.mmToInch(weightThread), 25, Color.BLACK, 34, 351, 0, Paint.Align.LEFT);
                    drawText(canvas, UtilsConvert.mmToInch(sPitch), 25, Color.BLACK, 477, 346, 0, Paint.Align.CENTER);
                    drawText(canvas, "ø " + UtilsConvert.mmToInch(sDiam), 25, Color.BLACK, 968, 221, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + UtilsConvert.mmToInch(middleDiam), 25, Color.BLACK, 860, 268, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + UtilsConvert.mmToInch(miniorNuts), 25, Color.BLACK, 737, 326, -90, Paint.Align.RIGHT);
                }

            } else {
                if (isExternal) {
                    drawText(canvas, weightThread, 25, Color.BLACK, 30, 74, 0, Paint.Align.LEFT);
                    drawText(canvas, sPitch, 25, Color.BLACK, 470, 337, 0, Paint.Align.CENTER);
                    drawText(canvas, "ø " + sDiam, 25, Color.BLACK, 966, 222, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + middleDiam, 25, Color.BLACK, 856, 275, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + formatDecimal(basicMiniordBolt), 25, Color.BLACK, 736, 341, -90, Paint.Align.RIGHT);

                } else {

                    drawText(canvas, (weightThread), 25, Color.BLACK, 34, 351, 0, Paint.Align.LEFT);
                    drawText(canvas, (sPitch), 25, Color.BLACK, 477, 346, 0, Paint.Align.CENTER);
                    drawText(canvas, "ø " + (sDiam), 25, Color.BLACK, 968, 221, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + (middleDiam), 25, Color.BLACK, 860, 268, -90, Paint.Align.RIGHT);
                    drawText(canvas, "ø " + (miniorNuts), 25, Color.BLACK, 737, 326, -90, Paint.Align.RIGHT);
                }
            }
        }

        void resizedBitmapFullView(Canvas canvas, Bitmap bm) {
            float canvasWidth = getWidth();
            float canvasHeight = getHeight();
            float bitmapOriginalWidth = bm.getWidth();
            float bitmapOriginalHeight = bm.getHeight();
            float xScale = canvasWidth / bitmapOriginalWidth;
            float yScale = canvasHeight / bitmapOriginalHeight;
            scaleImage = (xScale <= yScale) ? xScale : yScale;
            matrix.reset();
            matrix.postScale(scaleImage, scaleImage);
            resizedBitmap = Bitmap.createBitmap(bm, 0, 0, bm.getWidth(), bm.getHeight(), matrix, true);
            pointX = (canvasWidth / 2) - ((bitmapOriginalWidth * scaleImage) / 2);
            pointY = (canvasHeight - (bitmapOriginalHeight * scaleImage)) / 2;
            canvas.drawBitmap(resizedBitmap, (canvasWidth / 2) - ((bitmapOriginalWidth * scaleImage) / 2), (canvasHeight - (bitmapOriginalHeight * scaleImage)) / 2, null);

            //bm.recycle();
            resizedBitmap.recycle();


        }


        private void drawText(Canvas canvas, String text, float textSize, int color, float X, float Y, float rotate, Paint.Align objects, boolean isBackground) {
            float nullPointX = (pointX + (X * scaleImage) * dpi);
            float nullPointY = (pointY + (Y * scaleImage) * dpi);
//            canvas.save(Canvas.MATRIX_SAVE_FLAG);
            canvas.save();
            if (rotate != 0) {
                canvas.rotate(rotate, nullPointX, nullPointY);
                //canvas.save(Canvas.MATRIX_SAVE_FLAG);

            }
            paint.setAntiAlias(true);
            paint.setStyle(Paint.Style.FILL);
            if (isBackground) {
                if (objects == Paint.Align.CENTER) {
                    float widhtText = paint.measureText(text);
                    paint.setColor(getResources().getColor(R.color.background));
                    canvas.drawRect(nullPointX -
                                    (pointX + ((widhtText / 1.5f) * scaleImage) * dpi),
                            nullPointY - textSize * dpi,
                            nullPointX + (pointX + ((widhtText / 1.5f) * scaleImage) * dpi),
                            nullPointY, paint);
                }
            }
            paint.setTextAlign(objects);
            paint.setColor(color);
            paint.setTextSize(dpi * textSize);

            canvas.drawText(text, nullPointX, nullPointY, paint);

            canvas.restore();


        }

        private void drawText(Canvas canvas, String text, float textSize, int color, float X, float Y, float rotate, Paint.Align objects) {
            drawText(canvas, text, textSize, color, X, Y, rotate, objects, false);

        }
    }


}


















 */
