//
//  About.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 25.05.2022.
//

import SwiftUI

struct About: View {
    let newsAnalysis = """
    Работа на новостях является одним из основных элементов понимания движения цен на фондовом рынке и успешных инвестиций.
    Для успешной торговли на рынке необходимо своевременно определять наиболее значимые новости и понимать как данная новость повлияет на котировки тех или иных акций.
    Наш сервис предоставляет наиболее актуальные новости по всем компаниям Российского рынка и рынка США, а также прогнозирует их влияние на будущее изменение цен.
    """
    
    let binaryBarrier = """
    В приложении отображаются вероятности на рост средней цены от цены прошлого торгового дня/часа.
    Обе модели обучены на технических индикаторах.
    Бинарная(binary) модель прогнозирует произойдет ли рост или падение относительно средней цены текущего дня.
    Барьерная(barrier) же модель дает более точные прогнозы относительно направления изменения цены и имеет три результата:
        -цена вырастет
        -останется в том же ценовом диапазон
        -цена упадет
    """
    
    let index = """
    Индекс инвестиционной привлекательности показывает привлекательность инвестиций в определенный финансовый инструмент основываясь на результатах разработанных моделей.
    Рассчитывается как агрегация результатов работы каждой из предсказательных моделей и средней тональности новостей за день.
    Чем выше значение индекса тем более привлекательна компания в данный момент с точки зрения инвестиций.
    Индекс инвестиционной привлекательности отражается рядом с каждым инструментом в виде числа от 0 до 100.
    """
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Что такое новостной анализ?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text(newsAnalysis)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom])
                Text("Чем отличаются модели Binary и Barier?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text(binaryBarrier)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom])
                Text("Что такое индекс инвестиционной привлекательности?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text(index)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .navigationTitle("О приложении")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
