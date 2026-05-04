import tabula as tb
import pandas as pd

# 1) PDF'ten tabloları oku, her şeyi string al
dfs = tb.read_pdf(
    "Result LR Men Senior.pdf",
    pages="all",
    pandas_options={"dtype": str}
)

df = pd.concat(dfs, ignore_index=True)

# 2) Sütun adlarını BÜYÜK harf yap
df.columns = [str(col).upper() for col in df.columns]

# 3) TIME sütununu bozulmadan sakla (RAW kopya)
if 'TIME' in df.columns:
    df['TIME_RAW'] = df['TIME'].astype(str)

    # Excel'in otomatik saat yorumlamasını bozmak için sonuna " s" ekle
    df['TIME_DISPLAY'] = df['TIME_RAW'] + " s"
else:
    print("TIME sütunu bulunamadı, kolon adlarını kontrol et:")
    print(df.columns)

# 4) Diğer tüm metin kolonlarını büyük harfe çevir
text_cols = df.select_dtypes(include=["object", "string"]).columns
for col in text_cols:
    df[col] = df[col].astype(str).str.upper()

# 5) CSV'yi kaydet
df.to_csv("output_upper.csv", index=False)

print("✓ output_upper.csv oluşturuldu (TIME_RAW içinde PDF'teki orijinal süre, TIME_DISPLAY Excel için).")
